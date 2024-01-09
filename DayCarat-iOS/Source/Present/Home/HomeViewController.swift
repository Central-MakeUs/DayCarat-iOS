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
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    private let backgroundImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "Background")
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
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .red
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let recentEpisodeLabel = DayCaratLabel(type: .Subhead3, text: "최근 에피소드", textColor: .black)
    private let recentEpisodeCollectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HelpCollectionViewCell.self,
                    forCellWithReuseIdentifier: HelpCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .red
        $0.contentInsetAdjustmentBehavior = .never
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let bannerCollectioView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HelpCollectionViewCell.self,
                    forCellWithReuseIdentifier: HelpCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .red
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configure() {
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        self.scrollView.isUserInteractionEnabled = true
        print("ContentSize:", scrollView.contentSize)
        print("View Frame Size:", view.frame.size)

    }
    
    override func addView() {
        self.view.addSubview(backgroundImg)
        self.view.addSubview(scrollView)
        [logoImg, bellBtn,titleLabel, countView, helpCollectioView, recentEpisodeLabel,
         recentEpisodeCollectioView, bannerCollectioView].forEach {
            self.scrollView.addSubview($0)
        }
        [countIntroLabel, countNumLabel, countLabel].forEach {
            countView.addSubview($0)
        }
        
    }
    
    override func layout() {
        self.backgroundImg.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
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

    }
    
    override func binding() {
        Observable.just([0, 1, 2])
            .bind(to: helpCollectioView.rx.items(cellIdentifier: HelpCollectionViewCell.identifier, cellType: HelpCollectionViewCell.self))
        {  index, item, cell in
//            cell.configureCell(img: "")
        }
        .disposed(by: disposeBag)
    }
}
