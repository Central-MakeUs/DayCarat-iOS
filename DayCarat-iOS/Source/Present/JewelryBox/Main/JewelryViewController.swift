//
//  JewelryViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

final class JewelryViewController: BaseViewController {
    //MARK: - Properties

    private var disposeBag = DisposeBag()
    private var dataSource: RxCollectionViewSectionedReloadDataSource<GemSection>!
    private let viewModel: JewelryBoxViewModel
    private var gemCount = 0
    private var tag = ""
    private var nickName = ""
    private var stregth = ""
    private var userClass = ""
    private var userImg = ""
    private var keyword = ""
    private var totalCount = 0

    private let jewelryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(JewelryBodyCell.self, forCellWithReuseIdentifier: JewelryBodyCell.identifier)
        $0.register(JewelryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: JewelryHeaderView.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16)
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 168, height: 144)
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //MARK: - LifeCycle

    init( viewModel: JewelryBoxViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.upadetGemData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Method

    override func viewWillAppear(_ animated: Bool) {
        viewModel.upadetGemData()
    }
    
    override func configure() {
        jewelryCollectionView.delegate = self
        setupDataSource()
    }
    
    override func addView() {
        self.view.addSubview(jewelryCollectionView)
    }
    
    override func layout() {
        jewelryCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    override func binding() {
        
        viewModel.gemKeywordData
            .map { [GemSection(items: $0)] }
            .bind(to: jewelryCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        jewelryCollectionView.rx
            .modelSelected(GemKeywordInfo.self)
            .bind(onNext: {  [weak self]  keyword in
                self?.viewModel.coordinator?.pushGemKeywordList(keyword: keyword.title, count: String(keyword.count), type: .gem
                                                                , keywordtype: keyword.keyword)
            })
            .disposed(by: disposeBag)
        
        viewModel.headerData
            .bind(onNext: {  [weak self] res in
                self?.gemCount = res.month.gemCount
                self?.tag = res.mostActivity.activityTag
                self?.keyword = res.mostKeyword.episodeKeyword
                self?.totalCount = res.total.gemCount
                self?.jewelryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.userData
            .subscribe(onNext: {  [weak self]  res in
                self?.nickName = res.nickname
                self?.stregth = res.strength
                self?.userClass = res.userClass
                self?.userImg = res.profileImage ?? ""
                self?.jewelryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    private func setupDataSource() {
        
        dataSource = RxCollectionViewSectionedReloadDataSource<GemSection>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JewelryBodyCell.identifier, for: indexPath) as! JewelryBodyCell
                cell.configure(title: item.title, count: String(item.count), img: item.image)
                return cell
            }, 
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: JewelryHeaderView.identifier, for: indexPath) as! JewelryHeaderView
                headerView.userConfigure(name: self.nickName, strength: self.stregth, img: self.userImg, classStr: self.userClass)
                headerView.configure(month: self.gemCount, total: self.totalCount, tag: self.tag, keyword: self.keyword)
                return headerView
            }
        )
    }
}
//MARK: - Extension

extension JewelryViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 439)
        }
        return CGSize(width: view.frame.width, height: 0)
    }
}
