//
//  EpisodeViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class EpisodeViewController: BaseViewController {
    
    // MARK: - Properties

    private var disposeBag = DisposeBag()
    private let viewModel: EpisodeViewModel
    private var dataSource: RxCollectionViewSectionedReloadDataSource<EpisodeSection>!
    private var allEpisodeCount: epiCount?

    // MARK: -  UI

    private let bottomView = UIView().then {
        $0.backgroundColor = .white
    }
    private let episodeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(EpisodeBodyCell.self, forCellWithReuseIdentifier: EpisodeBodyCell.identifier)
        $0.register(EpisodeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpisodeHeaderView.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.3, height: 90)
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - init

    init(viewModel: EpisodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  Methods

    override func configure() {
        self.view.backgroundColor = .Main50
        self.episodeCollectionView.delegate = self
        self.viewModel.updateData()
        setupDataSource()
    }

    override func addView() {
        self.view.addSubview(bottomView)
        [episodeCollectionView].forEach {
            self.view.addSubview($0)
        }
    }

    override func layout() {
        self.bottomView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(episodeCollectionView.snp.bottom)
        }
        episodeCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }

    override func binding() {
        viewModel.activityEpi
            .map { [EpisodeSection(items: $0)] }
            .bind(to: episodeCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        episodeCollectionView.rx.modelSelected(ActivityEpiQuantityDTO.self)
            .subscribe(onNext: { [weak self] select in
                self?.viewModel.coordinator?.startList(title: select.activityTagName, count: String(select.quantity), type: .gem)
            })
            .disposed(by: disposeBag)
        
        viewModel.allCount
            .bind(onNext: { [weak self] count in
                self?.allEpisodeCount = count
                self?.episodeCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedReloadDataSource<EpisodeSection>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeBodyCell.identifier, for: indexPath) as! EpisodeBodyCell
                cell.configure(title: item.activityTagName, count: String(item.quantity))
                return cell
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpisodeHeaderView.identifier, for: indexPath) as! EpisodeHeaderView
                if let count = self.allEpisodeCount {
                    headerView.configure(count: String(count.episodeCount))
                }
                return headerView
            }
        )
    }
}
//MARK: - Extension

extension EpisodeViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 286)
        }
        return CGSize(width: view.frame.width, height: 0)
    }
}

