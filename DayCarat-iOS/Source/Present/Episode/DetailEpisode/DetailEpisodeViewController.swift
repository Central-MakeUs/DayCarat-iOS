//
//  DetailEpisodeViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/12.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class DetailEpisodeViewController: BaseViewController {
    private var dataSource: RxCollectionViewSectionedReloadDataSource<DetailEpiSection>!
    private var disposeBag = DisposeBag()
    private let viewModel: DetailEpisodeViewModel
    private let epiData = BehaviorRelay<[String]>(value: [])
    private let input = DetailEpisodeViewModel.Input()
    private let epiId: Int
    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "", middleText: "")
    private var titleStr = ""
    private var date = ""
    private var tag = ""

    private let detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(DetailEpiBodySection.self, forCellWithReuseIdentifier: DetailEpiBodySection.identifier)
        $0.register(DetailEpiHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailEpiHeaderView.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 16, bottom: 60, right: 16)
        layout.minimumInteritemSpacing = 20
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let trimBtn = DayCaratBtn(type: .Jump, text: "에피소드 다듬기")
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    init(viewModel: DetailEpisodeViewModel, id: Int) {
        self.viewModel = viewModel
        self.epiId = id
        super.init(nibName: nil, bundle: nil)
        viewModel.updateData(id: id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.view.backgroundColor = UIColor(hexString: "#F9F9F9")
        self.naviBar.delegate = self
        self.detailCollectionView.delegate = self
        setupDataSource()
    }
    
    override func addView() {
        [naviBar, detailCollectionView].forEach {
            self.view.addSubview($0)
        }
        view.addSubview(trimBtn)
    }
    
    override func layout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.naviBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        trimBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(4)
        }
    }
    
    override func binding() {
        
        viewModel.episodeContents
            .map { [DetailEpiSection(items: $0)] }
            .bind(to: detailCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.episodeContents
            .map { $0.map { $0.content } }
            .subscribe(onNext: {  [weak self]  res in
                self?.epiData.accept(res)
            })
            .disposed(by: disposeBag)
        
        trimBtn.rx
            .tap
            .asDriver()
            .drive(onNext: {  [weak self] _ in
                self?.viewModel.coordinator?.pushSoara(id: self?.epiId ?? 0)
            })
            .disposed(by: disposeBag)
        
        viewModel.detailData
            .bind(onNext: {  [weak self] res in
                self?.titleStr = res.title
                self?.date = res.selectedDate
                self?.tag = res.activityTagName

                self?.detailCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupDataSource() {

        dataSource = RxCollectionViewSectionedReloadDataSource<DetailEpiSection>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailEpiBodySection.identifier, for: indexPath) as! DetailEpiBodySection
                cell.configure(title: item.episodeContentType, des: item.content)
                return cell
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailEpiHeaderView.identifier, for: indexPath) as! DetailEpiHeaderView

                headerView.configure(title: self.titleStr , date: self.date, tag: "#\(self.tag)")

                return headerView
            }
        )
    }
}
extension DetailEpisodeViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 90)
        }
        return CGSize(width: view.frame.width, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = epiData.value
        let item = items[indexPath.item]
        let cell = DetailEpiBodySection()
        cell.configureDes(des: item)
        cell.layoutIfNeeded()
        let cellWidth = cell.desLabel.intrinsicContentSize.height + 32
        print("디테일뷰===================\(cellWidth)")
        print(cellWidth)

        return CGSize(width: 360, height: cellWidth)
    }
}
extension DetailEpisodeViewController: CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar: CustomNavigaitonBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightBtnClick(_ navibar: CustomNavigaitonBar) {
        
    }
}
