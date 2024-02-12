//
//  EpisodeInputViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources
import PanModal
import RxKeyboard

final class EpisodeInputViewController: BaseViewController {
    private let viewModel: EpisodeInputViewModel
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel>!
    private var disposeBag = DisposeBag()
    private var sectionsRelay = BehaviorRelay<[SectionModel]>(value: [SectionModel(items: [0, 1])])
    private let sections = [SectionModel(items: [0, 1])]
    private var cellContents: [EpisodeInputContent] = []
    let selectedDate = PublishRelay<String>()
    let titleStr = PublishRelay<String>()
    let activityTag = PublishRelay<String>()
    private var currentTitle: String?
       private var currentDate: String?
       private var currentActivityTag: String?
    
    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "저장", middleText: "에피소드 입력")
    private let epiInputCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(EpiInputCollectionViewCell.self, forCellWithReuseIdentifier: EpiInputCollectionViewCell.identifier)
        $0.register(EpiInputHeadrView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpiInputHeadrView.identifier)
        $0.register(EpiInputFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: EpiInputFooterView.identifier)

        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 267)
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(viewModel: EpisodeInputViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        sectionsRelay = BehaviorRelay<[SectionModel]>(value: [SectionModel(items: [0, 1])])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.naviBar.delegate = self
        self.epiInputCollectionView.delegate = self
        self.naviBar.backgroundColor = .clear
        setupDataSource()
    }
    
    override func addView() {
        [naviBar, epiInputCollectionView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(42)
        }
        epiInputCollectionView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    func updateCellContent(at index: Int, content: EpisodeInputContent) {
        if cellContents.indices.contains(index) {
            cellContents[index] = content
        } else {
            cellContents.append(content)
        }
        print(cellContents)
    }
    override func binding() {
        
        sectionsRelay
            .asObservable()
            .bind(to: epiInputCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
                guard let self = self else { return }
                
                var insets = self.epiInputCollectionView.contentInset
                insets.bottom = keyboardVisibleHeight
                
                self.epiInputCollectionView.contentInset = insets
                self.epiInputCollectionView.scrollIndicatorInsets = insets
                
                if keyboardVisibleHeight > 0 {
                    
                }
            })
            .disposed(by: self.disposeBag)
        
        titleStr
            .subscribe(onNext: { [weak self] title in
                self?.currentTitle = title
            })
            .disposed(by: disposeBag)

        selectedDate
            .subscribe(onNext: { [weak self] date in
                self?.currentDate = date
            })
            .disposed(by: disposeBag)

        activityTag
            .subscribe(onNext: { [weak self] tag in
                self?.currentActivityTag = tag
            })
            .disposed(by: disposeBag)
    }
    
    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpiInputCollectionViewCell.identifier, for: indexPath) as! EpiInputCollectionViewCell
                cell.cellContents
                    .subscribe(onNext: { [weak self] newContent in
                        self?.updateCellContent(at: indexPath.row, content: newContent)
                    })
                    .disposed(by: cell.disposeBag)
                return cell
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                if kind == UICollectionView.elementKindSectionHeader {
                    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpiInputHeadrView.identifier, for: indexPath) as! EpiInputHeadrView
                    headerView.calendarButtonTap
                        .subscribe(onNext: { [weak self] _ in
                            let vc = CalnderViewController(viewModel: EpisodeInputViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService()), gemRepository: GemRepository(service: GemService())), coordinator: nil))
                            vc.strDate
                                .subscribe(onNext: { [weak self] date in
                                    headerView.date.accept(date)
                                    self?.selectedDate.accept(date)
                                })
                                .disposed(by: vc.disposeBag)
                            self?.presentPanModal(vc)
                        })
                        .disposed(by: self.disposeBag)
                    headerView.titleSubject
                        .subscribe(onNext: { [weak self] title in
                            self?.titleStr.accept(title)
                        })
                        .disposed(by: self.disposeBag)
                    return headerView
                } else if kind == UICollectionView.elementKindSectionFooter {
                    let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpiInputFooterView.identifier, for: indexPath) as! EpiInputFooterView
                    footerView.addBtn.rx
                        .tap
                        .asDriver()
                        .drive(onNext: { [weak self] in
                            guard let self = self else { return }
                            var currentSections = self.sectionsRelay.value
                            if currentSections[0].items.count < 4 {
                                currentSections[0].items.append(currentSections[0].items.count)
                                self.sectionsRelay.accept(currentSections)
                            }
                            self.updateFooterViewVisibility(cellCount: currentSections[0].items.count)
                        })
                        .disposed(by: self.disposeBag)
                    
                    return footerView
                }
                else {
                    fatalError("Unexpected supplementary view kind: \(kind)")
                }
            }
        )
    }
    private func updateFooterViewVisibility(cellCount: Int) {
        if cellCount >= 4 {
            epiInputCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 0))?.isHidden = true
        } else {
            epiInputCollectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 0))?.isHidden = false
        }
    }
}
extension EpisodeInputViewController: CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar: CustomNavigaitonBar) {
        self.viewModel.coordinator?.popupViewController(animated: true)
    }
    
    func rightBtnClick(_ navibar: CustomNavigaitonBar) {
            print("asdsa")
        self.viewModel.registerEpi(title: currentTitle ?? "", date: self.currentDate ?? "2024-01-01", activityTag: currentActivityTag ?? "CMC", episodeContents: self.cellContents )
            
    }
}
extension EpisodeInputViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 211)
        }
        return CGSize(width: 0, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height:52)
        }
        return CGSize(width: 0, height: 0)
    }
}
