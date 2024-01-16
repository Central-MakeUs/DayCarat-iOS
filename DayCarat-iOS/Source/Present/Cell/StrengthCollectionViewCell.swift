//
//  StrengthCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/09.
//

import UIKit

final class StrengthCollectionViewCell: UICollectionViewCell {
    static let identifier = "StrengthCollectionViewCell"
    
    let text = DayCaratLabel(type: .Body2, text: "", textColor: .Gray700!).then {
        $0.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureCell(item: String) {
        self.text.text = item
        self.layer.cornerRadius = 15
    }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .Gray200
        
        self.addSubview(text)
        text.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
