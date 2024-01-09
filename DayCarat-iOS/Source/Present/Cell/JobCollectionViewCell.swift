//
//  JobCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/8/24.
//

import UIKit

final class JobCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "JobCollectionViewCell"
    
    let text = DayCaratLabel(type: .Body1, text: "", textColor: .Gray500!)
    
    func configureCell(item: String) {
        self.text.text = item
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Gray500?.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.addSubview(text)
        text.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
