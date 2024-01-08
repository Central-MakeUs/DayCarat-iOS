//
//  OnBoardingCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnBoardingCollectionViewCell"
    private let firstView = InputNameSection()
    private let secondView = JobSection()
    private let thirdView = StrengthSection()
    
    private var currentIndex: Int = 0

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
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
