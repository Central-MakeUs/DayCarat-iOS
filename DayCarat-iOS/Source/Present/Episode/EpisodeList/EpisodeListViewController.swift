//
//  EpisodeListViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/10/24.
//

import UIKit

import RxCocoa
import RxSwift
import RxDataSources

final class EpisodeListViewController: BaseViewController {
    
    private var disposeBag = DisposeBag()
    private var dataSource: RxCollectionViewSectionedReloadDataSource<GemKeywordSection>!
    private var activityDataSource: RxCollectionViewSectionedReloadDataSource<ActivityEpisodeSection>!
    private let viewModel: EpisodeListViewModel
    private let type: EpiListType
    private let naviBar = CustomNavigaitonBar(btnstate: false, rightBtnText: "", middleText: "")
    private let emptyImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "emptyBox")
    }
    private let episodeListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(EpisodeListCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeListCollectionViewCell.identifier)
        $0.register(EpisodeListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpisodeListHeaderView.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 328, height: 128)
        layout.minimumInteritemSpacing = 12
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(viewModel: EpisodeListViewModel, type: EpiListType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        
        switch type {
            
        case .epi:
            activitydataSource()
        case .gem:
            setupDataSource()
        }
        
        naviBar.delegate = self
        episodeListCollectionView.delegate = self
        self.view.backgroundColor = UIColor(hexString: "#F9F9F9")
    }
    
    override func addView() {
        self.view.addSubview(naviBar)
        self.view.addSubview(episodeListCollectionView)
        self.episodeListCollectionView.addSubview(emptyImg)
    }
    
    override func layout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(42)
        }
        episodeListCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.naviBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        emptyImg.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(235)
        }
    }
    
    override func binding() {
        
        switch type {
        case .epi:
            
        case .gem:
            viewModel.keywordGemList
                    .map { [GemKeywordSection(items: $0)] }
                    .bind(to: episodeListCollectionView.rx.items(dataSource: dataSource))
                    .disposed(by: disposeBag)
                
            episodeListCollectionView.rx.modelSelected(GemKeywordEpi.self)
                    .subscribe(onNext: { [weak self] res in
                        
                    })
                    .disposed(by: disposeBag)
        }
    }

    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<GemKeywordSection>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeListCollectionViewCell.identifier, for: indexPath) as! EpisodeListCollectionViewCell
                if indexPath.count == 0 {
                    self.emptyImg.isHidden = false
                } else {
                    self.emptyImg.isHidden = true
                }
                cell.configure(title: item.title, date: item.date, des: item.content)
                return cell
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpisodeListHeaderView.identifier, for: indexPath) as! EpisodeListHeaderView
                headerView.configure(title: self.viewModel.headerTitle, count: self.viewModel.headerCount)
                return headerView
            }
        )
    }
    
    private func activitydataSource() {
        activityDataSource = RxCollectionViewSectionedReloadDataSource<ActivityEpisodeSection>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeListCollectionViewCell.identifier, for: indexPath) as! EpisodeListCollectionViewCell
                if indexPath.count == 0 {
                    self.emptyImg.isHidden = false
                } else {
                    self.emptyImg.isHidden = true
                }
                cell.configure(title: item.title, date: item.date, des: item.content)
                return cell
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpisodeListHeaderView.identifier, for: indexPath) as! EpisodeListHeaderView
                headerView.configure(title: self.viewModel.headerTitle, count: self.viewModel.headerCount)
                return headerView
            }
        )
    }
}
extension EpisodeListViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 50)
        }
        return CGSize(width: view.frame.width, height: 0)
    }
}
extension EpisodeListViewController: CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar: CustomNavigaitonBar) {
        self.viewModel.coordinator?.popupViewController(animated: true)
    }
    
    func rightBtnClick(_ navibar: CustomNavigaitonBar) {
        
    }
}
