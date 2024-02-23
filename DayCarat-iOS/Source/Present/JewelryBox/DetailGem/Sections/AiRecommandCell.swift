//
//  AiRecommandCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/10/24.
//

import UIKit

final class AiRecommandCell: UICollectionViewCell {
    static let identifier = "AiRecommandHeader"
    
    private let titleLabel = DayCaratLabel(type: .Subhead5, text: "AI 추천 문장", textColor: .Main!)
    

    private func addView() {
        self.backgroundColor = .main50
        [titleLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(24)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
