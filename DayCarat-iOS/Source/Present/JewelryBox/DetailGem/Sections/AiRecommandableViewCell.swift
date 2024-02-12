//
//  AiRecommandableViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/12/24.
//

import UIKit

class AiRecommandableViewCell: UICollectionViewCell {
    static let identifier = "AiRecommandableViewCell"

    let desLabel = DayCaratLabel(type: .Body2, text: "", textColor: .Gray700!)
    
    private let circleLabel = DayCaratLabel(type: .Body5, text: "*", textColor: .Gray700!)

    
    private func layout() {
        [desLabel, circleLabel].forEach {
            self.addSubview($0)
        }
        circleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        desLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(circleLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width - 50)

            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(des: String) {
        self.desLabel.text = des
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
