//
//  StrengthSection.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import UIKit

import RxSwift
import RxCocoa

final class StrengthSection: BaseView {
    
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "내가 생각하는 나의 강점은?", textColor: .Gray800!)
    private let desLabel = DayCaratLabel(type: .Body1, text: "선택하신 직군에 따라\n에피소드 키워드를 추천해드려요.", textColor: .Gray600!)
    let strengthData = BehaviorRelay<[String]>(value: [])
    let choiceStrength = PublishSubject<String>()
    private var selectedIndexPath: IndexPath?
    private let disposeBag = DisposeBag()
    private let strengthCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(StrengthCollectionViewCell.self,
                    forCellWithReuseIdentifier: StrengthCollectionViewCell.identifier)
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 3
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        self.strengthCollectionView.delegate = self
    }
    
    override func addview() {
        [titleLabel, desLabel, strengthCollectionView].forEach {
            self.addSubview($0)
        }
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
        strengthCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.desLabel.snp.bottom).offset(42)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(304)
        }
    }
    
    override func binding() {
        strengthData
            .bind(to: strengthCollectionView.rx.items(cellIdentifier: StrengthCollectionViewCell.identifier, cellType: StrengthCollectionViewCell.self))
        {  index, item, cell in
            
            cell.configureCell(item: item)
        }
        .disposed(by: disposeBag)
        
        strengthCollectionView.rx.modelSelected(String.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {  [weak self] selectedStrength in
                if let selectedIndexPath = self?.strengthCollectionView.indexPathsForSelectedItems?.first,
                   let _ = self?.strengthCollectionView.cellForItem(at: selectedIndexPath) as? StrengthCollectionViewCell {
                    guard let self = self else { return }

                    if let previousSelectedIndexPath = self.selectedIndexPath,
                       let previousSelectedCell = self.strengthCollectionView.cellForItem(at: previousSelectedIndexPath) as? StrengthCollectionViewCell {
                        previousSelectedCell.text.textColor = .Gray700
                        previousSelectedCell.backgroundColor = .Gray200
                    }

                    if let selectedIndexPath = self.strengthCollectionView.indexPathsForSelectedItems?.first,
                       let selectedCell = self.strengthCollectionView.cellForItem(at: selectedIndexPath) as? StrengthCollectionViewCell {
                        self.choiceStrength.onNext(selectedStrength)
                        selectedCell.text.textColor = .white
                        selectedCell.backgroundColor = .Main
                        self.selectedIndexPath = selectedIndexPath
                    }
                }
            })
            .disposed(by: disposeBag)

    }
}
extension StrengthSection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = strengthData.value
        let item = items[indexPath.item]

        let cell = StrengthCollectionViewCell()
        cell.configureCell(item: item)
        cell.layoutIfNeeded()

        let cellWidth = cell.text.intrinsicContentSize.width + 32

        return CGSize(width: cellWidth, height: 32)
    }
}
