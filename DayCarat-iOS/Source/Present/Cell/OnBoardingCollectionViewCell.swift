//
//  OnBoardingCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import UIKit

import RxGesture
import RxSwift

class OnBoardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnBoardingCollectionViewCell"
    private let firstView = InputNameSection()
    private let secondView = JobSection()
    private let thirdView = StrengthSection()
    var onSubviewTapped: (() -> Void)?
    var inputNameSection: InputNameSection? {
        return firstView
    }

    private var currentIndex: Int = 0
    var disposeBag = DisposeBag()

    func configureCell(index: Int) {
         currentIndex = index
        removeAllSubviews()

         switch index {
         case 0:
             addSubview(firstView)
             firstView.snp.makeConstraints {
                 $0.edges.equalToSuperview()
             }
         case 1:
             addSubview(secondView)
             secondView.snp.makeConstraints {
                 $0.edges.equalToSuperview()
             }
         case 2:
             addSubview(thirdView)
             thirdView.snp.makeConstraints {
                 $0.edges.equalToSuperview()
             }

         default:
             break
         }
     }
    
    private func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    func setupGestureRecognizer() {
        firstView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.onSubviewTapped?()
            })
            .disposed(by: disposeBag)
        secondView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.onSubviewTapped?()
            })
            .disposed(by: disposeBag)
        thirdView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.onSubviewTapped?()
            })
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
