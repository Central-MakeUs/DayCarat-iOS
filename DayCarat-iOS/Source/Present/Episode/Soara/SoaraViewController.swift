//
//  SoaraViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/22/24.
//

import UIKit

import RxSwift
import RxCocoa

final class SoaraViewController: BaseViewController {
    //MARK: - Properties

    private let viewModel: SoaraViewModel
    
    //MARK: - UI
    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "", middleText: "")
    
    private let scrollView = UIScrollView()
    private let contentSV = UIStackView().then {
        $0.axis = .vertical
    }
    private let topView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "", textColor: .Gray900!)
    private let dateLabel = DayCaratLabel(type: .Body3, text: "", textColor: .Gray500!)
    private let epiLabel = DayCaratLabel(type: .Subhead4, text: "에피소드 내용", textColor: .Gray900!)
    private let epiBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .black
    }
    private let lineView = UIView().then {
        $0.backgroundColor = .Gray300
        $0.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    private let soaraLabel = DayCaratLabel(type: .Subhead1, text: "", textColor: .Gray900!)
    private let epiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(EpiCollectionViewCell.self, forCellWithReuseIdentifier: EpiCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //layout.sectionInset = UIEdgeInsets(top: 24, left: 16, bottom: 60, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 361, height: 47)
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    //MARK: - LifeCycle
    
    init(viewModel: SoaraViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    override func configure() {
        
    }
    
    override func addView() {
        self.view.addSubview(naviBar)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentSV)
        [titleLabel, dateLabel, epiLabel, epiBtn].forEach {
            self.topView.addSubview($0)
        }
        [topView, epiCollectionView, lineView].forEach {
            self.contentSV.addArrangedSubview($0)
        }
    }
    
    override func layout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(42)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.naviBar.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        contentSV.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        topView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(146)
        }
    }
    
    override func binding() {
        
    }
}
