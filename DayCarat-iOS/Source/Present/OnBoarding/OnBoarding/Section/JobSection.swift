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
    private var selectedIndexPath: IndexPath?
    private let disposeBag = DisposeBag()
    let jobData = PublishSubject<[String]>()
    let choiceJob = PublishSubject<String>()
    let btnState = PublishSubject<Bool>()
    private let jobCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(JobCollectionViewCell.self,
                    forCellWithReuseIdentifier: JobCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.itemSize = CGSize(width: 350, height: 48)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
    }
    
    override func addview() {
        [titleLabel, desLabel, jobCollectionView].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .clear
    }
    
    override func layout() {
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
        jobData
            .bind(to: jobCollectionView.rx.items(cellIdentifier: JobCollectionViewCell.identifier, cellType: JobCollectionViewCell.self))
        {   index, item, cell in
            cell.configureCell(item: item)
        }
        .disposed(by: disposeBag)
        
        jobCollectionView.rx.modelSelected(String.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] selectedJob in
                if let selectedIndexPath = self?.jobCollectionView.indexPathsForSelectedItems?.first,
                   let _ = self?.jobCollectionView.cellForItem(at: selectedIndexPath) as? JobCollectionViewCell {
                    guard let self = self else { return }

                    if let previousSelectedIndexPath = self.selectedIndexPath,
                       let previousSelectedCell = self.jobCollectionView.cellForItem(at: previousSelectedIndexPath) as? JobCollectionViewCell {
                        previousSelectedCell.text.textColor = .Gray500
                        previousSelectedCell.layer.borderColor = UIColor.Gray400?.cgColor
                    }

                    if let selectedIndexPath = self.jobCollectionView.indexPathsForSelectedItems?.first,
                       let selectedCell = self.jobCollectionView.cellForItem(at: selectedIndexPath) as? JobCollectionViewCell {
                        selectedCell.text.textColor = .Main
                        selectedCell.layer.borderColor = UIColor.Main?.cgColor
                        self.selectedIndexPath = selectedIndexPath
                        self.choiceJob.onNext(selectedJob)
                        self.btnState.onNext(true)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
