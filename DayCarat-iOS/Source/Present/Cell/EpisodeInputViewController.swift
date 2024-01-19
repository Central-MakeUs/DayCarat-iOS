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

class EpisodeInputViewController: BaseViewController {
    private let viewModel: EpisodeInputViewModel
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel>!
    private var disposeBag = DisposeBag()

    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "저장", middleText: "에피소드 입력")
    private let epiInputCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(EpiInputCollectionViewCell.self, forCellWithReuseIdentifier: EpiInputCollectionViewCell.identifier)
        $0.register(EpiInputHeadrView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpiInputHeadrView.identifier)
        
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
    
    override func binding() {
        let sections = [SectionModel(items: [0, 1])]
        
        Observable.just(sections)
            .bind(to: epiInputCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }
    
    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpiInputCollectionViewCell.identifier, for: indexPath) as! EpiInputCollectionViewCell
                
                return cell
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpiInputHeadrView.identifier, for: indexPath) as! EpiInputHeadrView
                
                return headerView
            }
        )
    }
}
extension EpisodeInputViewController: CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar: CustomNavigaitonBar) {
        self.viewModel.coordinator?.popupViewController(animated: true)
    }
    
    func rightBtnClick(_ navibar: CustomNavigaitonBar) {
        
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
}
