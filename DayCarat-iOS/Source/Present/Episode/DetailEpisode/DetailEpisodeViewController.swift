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
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel>!
    private var disposeBag = DisposeBag()

    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "편집", middleText: "")
    private let detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(DetailEpiBodySection.self, forCellWithReuseIdentifier: DetailEpiBodySection.identifier)
        $0.register(DetailEpiHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailEpiHeaderView.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 0, bottom: 10, right: 0)
        layout.minimumLineSpacing = 20
//        layout.itemSize = CGSize(width: 175, height: 184)
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let trimBtn = DayCaratBtn(type: .Default, text: "경험 다듬기")
    
    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailEpiBodySection.identifier, for: indexPath) as! DetailEpiBodySection
                
                return cell
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailEpiHeaderView.identifier, for: indexPath) as! DetailEpiHeaderView
                
                return headerView
            }
        )
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
        let sections = [SectionModel(items: [0, 1])]
        
        Observable.just(sections)
            .bind(to: detailCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
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
}
extension DetailEpisodeViewController: CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar: CustomNavigaitonBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightBtnClick(_ navibar: CustomNavigaitonBar) {
        
    }
}
