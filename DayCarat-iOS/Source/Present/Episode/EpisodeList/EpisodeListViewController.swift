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
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel>!
    private let viewModel: EpisodeListViewModel

    private let naviBar = CustomNavigaitonBar(btnstate: false, rightBtnText: "", middleText: "")
    private let episodeListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(EpisodeListCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeListCollectionViewCell.identifier)
        $0.register(EpisodeListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpisodeListHeaderView.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 361, height: 128)
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(viewModel: EpisodeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        setupDataSource()
        naviBar.delegate = self
        episodeListCollectionView.delegate = self
        self.view.backgroundColor = UIColor(hexString: "#F9F9F9")
    }
    
    override func addView() {
        self.view.addSubview(naviBar)
        self.view.addSubview(episodeListCollectionView)
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
    }
    
    override func binding() {
        let sections = [SectionModel(items: [0, 1, 2, 4,5,6,7,8,9])]
        
        Observable.just(sections)
            .bind(to: episodeListCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        episodeListCollectionView.rx.modelSelected(Int.self)
            .subscribe(onNext: { [weak self] selectedIdx in
                self?.viewModel.coordinator?.start()
            })
            .disposed(by: disposeBag)
    }

    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeListCollectionViewCell.identifier, for: indexPath) as! EpisodeListCollectionViewCell
                
                return cell
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpisodeListHeaderView.identifier, for: indexPath) as! EpisodeListHeaderView
                
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
