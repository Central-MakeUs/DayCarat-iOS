//
//  JobSection.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import UIKit

import RxSwift
import RxCocoa

class JobSection: BaseView {
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "희망하는 직군분야를 알려주세요.", textColor: .Gray800!)
    private let desLabel = DayCaratLabel(type: .Body1, text: "선택하신 직군에 따라\n에피소드 키워드를 추천해드려요.", textColor: .Gray600!)
    
    private let disposeBag = DisposeBag()
    private let viewModel = OnBoardingViewModel(usecase: OnBoardingUseCase())

    private let jobCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(JobCollectionViewCell.self,
                    forCellWithReuseIdentifier: JobCollectionViewCell.identifier)
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.itemSize = CGSize(width: 100, height: 48)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 16
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .red
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
    }
    
    override func addview() {
        [titleLabel, desLabel, jobCollectionView].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .clear
    }
    
    override func layout() {
        viewModel.updateInfo()
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        jobCollectionView.snp.makeConstraints {
            $0.top.equalTo(desLabel.snp.bottom).offset(42)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(304)
        }
    }
    
    override func binding() {
        
        viewModel.info
            .flatMap { Observable.just($0.jobs) }
            .bind(to: jobCollectionView.rx.items(cellIdentifier: JobCollectionViewCell.identifier, cellType: JobCollectionViewCell.self)) { index, item, cell in
                cell.configureCell(item: item)
                print("asdasd")
            }
            .disposed(by: disposeBag)
    }
}
