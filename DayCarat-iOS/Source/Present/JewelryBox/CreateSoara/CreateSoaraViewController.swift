//
//  CreateSoaraViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import UIKit

import RxSwift
import RxCocoa

final class CreateSoaraViewController: BaseViewController {
    
    //MARK: - UI

    private let scrollView = UIScrollView()
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "", middleText: "")
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "기획회의", textColor: .black)
    private let dateLabel = DayCaratLabel(type: .Body3, text: "2024년 1월12일 금요일", textColor: .Gray500!)
    private let creationKeywordView = UIView().then {
        $0.backgroundColor = .Gray100
        $0.layer.cornerRadius = 8
    }
    private let epiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(DetailEpiBodySection.self, forCellWithReuseIdentifier: DetailEpiBodySection.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .red
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
    private let dividerView = UIView().then {
        $0.backgroundColor = .Gray300
    }
    private let divider2View = UIView().then {
        $0.backgroundColor = .Gray300
    }
    private let creationAIRecommandView = UIView().then {
        $0.backgroundColor = .Main50
        $0.layer.cornerRadius = 8
    }
    private let soaraTitleLabel = DayCaratLabel(type: .Subhead3, text: "SOARA", textColor: .Gray900!)
    private let soaraImg = UIImageView().then {
        $0.image = UIImage(named: "icon-help-circle")
    }
    private let copyBtn = UIButton().then {
        $0.setImage(UIImage(named: "icon-copy"), for: .normal)
    }
    private let soaraCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(SoaraCollectionViewCell.self, forCellWithReuseIdentifier: SoaraCollectionViewCell.identifier)
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.sectionInsetReference = .fromContentInset
       // layout.itemSize = CGSize(width: 361, height: 47)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Method

    override func configure() {
        
    }
    
    override func addView() {
        self.view.addSubview(naviBar)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)

        [titleLabel, dateLabel, creationKeywordView, epiCollectionView, dividerView, creationAIRecommandView, soaraTitleLabel, soaraImg, copyBtn, soaraCollectionView, divider2View]
            .forEach {
                self.contentView.addSubview($0)
            }
    }
    
    override func layout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(42)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview().offset(0)
            $0.edges.equalToSuperview().offset(0)
            $0.height.equalTo(1200)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
        }
        dividerView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        creationKeywordView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(156)
        }
        epiCollectionView.snp.makeConstraints {
            $0.top.equalTo(creationKeywordView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }
        divider2View.snp.makeConstraints {
            $0.top.equalTo(epiCollectionView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        soaraTitleLabel.snp.makeConstraints {
            $0.top.equalTo(divider2View.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        soaraImg.snp.makeConstraints {
            $0.top.equalTo(divider2View.snp.bottom).offset(28)
            $0.leading.equalTo(soaraTitleLabel.snp.trailing).offset(6)
            $0.width.height.equalTo(24)
        }
        copyBtn.snp.makeConstraints {
            $0.top.equalTo(divider2View.snp.bottom).offset(28)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        creationAIRecommandView.snp.makeConstraints {
            $0.top.equalTo(soaraTitleLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(156)
        }
        soaraCollectionView.snp.makeConstraints {
            $0.top.equalTo(creationAIRecommandView.snp.bottom).offset(24)
            $0.trailing.leading.equalToSuperview()
        }
    }
    
    override func binding() {
        
    }
}
//MARK: - Extension

extension CreateSoaraViewController {
    private func calculateCollectionViewHeight(collectionView: UICollectionView, cellHeight: CGFloat, itemCount: Int) -> CGFloat {
        let totalCellHeight = cellHeight * CGFloat(itemCount)
        let totalSpacing = collectionView.layoutMargins.top + collectionView.layoutMargins.bottom
        return totalCellHeight + totalSpacing
    }
    
    private func updateCollectionViewHeight() {
        let epiCollectionViewHeight = calculateCollectionViewHeight(collectionView: epiCollectionView, cellHeight: 50, itemCount: epiCollectionView.numberOfItems(inSection: 0))
        let soaraCollectionViewHeight = calculateCollectionViewHeight(collectionView: soaraCollectionView, cellHeight: 50, itemCount: soaraCollectionView.numberOfItems(inSection: 0))

        epiCollectionView.snp.updateConstraints {
            $0.height.equalTo(epiCollectionViewHeight)
        }
        soaraCollectionView.snp.updateConstraints {
            $0.height.equalTo(soaraCollectionViewHeight)
        }
        self.view.layoutIfNeeded()
    }
}
