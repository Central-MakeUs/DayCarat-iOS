//
//  HomeViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

import RxSwift
import RxCocoa

final class HomeViewController: BaseViewController {
    private let viewModel: HomeViewModel
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let bottomView = UIView().then {
        $0.backgroundColor = .Gray50
        $0.layer.cornerRadius = 16
    }
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    private let backgroundImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "BackGround")
    }
    private let bellBtn = UIButton().then {
        $0.setImage(UIImage(named: "icon-bell"), for: .normal)
        $0.tintColor = .Gray800
    }
    private let logoImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "splashLogo")
    }
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "지철님,\n새로운 에피소드를 캐볼까요?",textColor: .Gray900!)
    private let folderImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "backFolder")
    }
    private let countView = UIView().then {
        $0.backgroundColor = .Main
        $0.layer.cornerRadius = 37
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        $0.layer.opacity = 0.7
    }
    private let countIntroLabel = DayCaratLabel(type: .Body3, text: "이번달\n나의 에피소드", textColor: .white)
    private let countNumLabel = DayCaratLabel(type: .Header2, text: "20", textColor: .white)
    private let countLabel = DayCaratLabel(type: .Subhead6, text: "개", textColor: .white)
    private let disposeBag = DisposeBag()
    private let helpCollectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HelpCollectionViewCell.self,
                    forCellWithReuseIdentifier: HelpCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 144, height: 144)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let recentEpisodeLabel = DayCaratLabel(type: .Subhead3, text: "최근 에피소드", textColor: .black)
    private let recentEpisodeCollectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(RecentEpiCollectionViewCell.self,
                    forCellWithReuseIdentifier: RecentEpiCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 361, height: 72)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let bannerCollectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(BannerCollectionViewCell.self,
                    forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 96)
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let pageControl = CustomPageControlView(numberOfPages: 3, width: 6, height: 6, spacing: 8, different: false)
    private let newsLabel = DayCaratLabel(type: .Subhead3, text: "데이캐럿 뉴스", textColor: .black)
    private let newsDesLabel = DayCaratLabel(type: .Body3, text: "데이캐럿 설명어쩌구저쩌구", textColor: .Gray600!)
    private let newsCollectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(NewsCollectionViewCell.self,
                    forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 175, height: 175)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.bannerCollectioView.delegate = self

    }
    
    override func addView() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.backgroundImg.addSubview(folderImg)
        [backgroundImg,bottomView, logoImg, bellBtn,titleLabel, countView, helpCollectioView, recentEpisodeLabel,
         recentEpisodeCollectioView, bannerCollectioView, newsLabel, newsDesLabel,
         newsCollectioView, pageControl].forEach {
            self.contentView.addSubview($0)
        }
        [countIntroLabel, countNumLabel, countLabel].forEach {
            countView.addSubview($0)
        }
    }
    
    override func layout() {
        self.folderImg.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(171.67)
            $0.height.equalTo(260.77)
        }
        self.contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
            $0.height.equalTo(1500)
        }
        self.backgroundImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-500)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(852)
        }
        self.bottomView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(318)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.trailing.leading.equalToSuperview()
        }
        self.logoImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.leading.equalTo(20)
            $0.width.equalTo(100.28)
            $0.height.equalTo(23)
        }
        self.bellBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.trailing.equalTo(self.view.snp.trailing).offset(-20)
            $0.width.height.equalTo(24)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImg.snp.bottom).offset(19)
            $0.leading.equalToSuperview().offset(20)
        }
        self.countView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(101)
            $0.leading.equalToSuperview().offset(-30)
            $0.width.equalTo(260)
            $0.height.equalTo(76)
        }
        self.countIntroLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(self.view.snp.leading).offset(23.09)
        }
        self.countNumLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalTo(countLabel.snp.leading)
        }
        self.countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(34.18)
            $0.trailing.equalToSuperview().offset(-24.61)
        }
        self.helpCollectioView.snp.makeConstraints {
            $0.top.equalTo(countView.snp.bottom).offset(48)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.height.equalTo(160)
        }
        self.recentEpisodeLabel.snp.makeConstraints {
            $0.top.equalTo(helpCollectioView.snp.bottom).offset(37)
            $0.leading.equalToSuperview().offset(16)
        }
        self.recentEpisodeCollectioView.snp.makeConstraints {
            $0.top.equalTo(recentEpisodeLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.height.equalTo(232)
        }
        self.bannerCollectioView.snp.makeConstraints {
            $0.top.equalTo(recentEpisodeCollectioView.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.height.equalTo(96)
        }
        self.pageControl.snp.makeConstraints {
            $0.top.equalTo(bannerCollectioView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        self.newsLabel.snp.makeConstraints {
            $0.top.equalTo(bannerCollectioView.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(16)
        }
        self.newsDesLabel.snp.makeConstraints {
            $0.top.equalTo(newsLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        self.newsCollectioView.snp.makeConstraints {
            $0.top.equalTo(newsDesLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(364)
        }

    }
    
    override func binding() {
        
        let input = HomeViewModel.Input()
        let output = viewModel.transform(input: input)
        
    
        
        Observable.just([0, 1, 2])
            .bind(to: helpCollectioView.rx.items(cellIdentifier: HelpCollectionViewCell.identifier, cellType: HelpCollectionViewCell.self))
        {  index, item, cell in
            output.sectionData
                .asDriver()
                .map { data in
                    return String(describing: data.helpCell[index])
                }
                .drive(onNext: { stringValue in
                    cell.configureCell(img: stringValue)
                })
                .disposed(by: cell.disposeBag)
        }
        .disposed(by: disposeBag)
        
        Observable.just([0, 1, 2])
            .bind(to: recentEpisodeCollectioView.rx.items(cellIdentifier: RecentEpiCollectionViewCell.identifier, cellType:RecentEpiCollectionViewCell.self))
        {  index, item, cell in
            
        }
        .disposed(by: disposeBag)
        
        recentEpisodeCollectioView.rx
            .modelSelected(Int.self)
            .subscribe(onNext: {  [weak self]  info in

            })
            .disposed(by: disposeBag)
        
        Observable.just([0, 1, 2])
            .bind(to: bannerCollectioView.rx.items(cellIdentifier: BannerCollectionViewCell.identifier, cellType:BannerCollectionViewCell.self))
        {  index, item, cell in
            cell.configureCell(img: "banner")
        }
        .disposed(by: disposeBag)
        
        Observable.just([0, 1, 2, 4])
            .bind(to: newsCollectioView.rx.items(cellIdentifier: NewsCollectionViewCell.identifier, cellType:NewsCollectionViewCell.self))
        {  index, item, cell in

        }
        .disposed(by: disposeBag)

    }
}
extension HomeViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: bannerCollectioView.contentOffset, size: bannerCollectioView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = bannerCollectioView.indexPathForItem(at: visiblePoint) {
            let currentIndex = indexPath.item
            self.pageControl.setCurrentPage(currentIndex)
        }
    }
}

