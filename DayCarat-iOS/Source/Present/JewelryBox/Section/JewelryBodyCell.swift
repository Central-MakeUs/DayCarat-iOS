//
//  JewelryBodyCell.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class JewelryBodyCell: UICollectionViewCell {
    static let identifier = "JewelryBodyCell"
    
    private let img = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "jewelryBox")
    }

    private let titleLabel = DayCaratLabel(type: .Subhead5, text: "활동명", textColor: .Gray900!)
    private let countLabel = DayCaratLabel(type: .Subhead6, text: "24", textColor: .Main!)
    
    private func applyShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.Gray600?.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3
    }

    private func addView() {
        self.addSubview(img)
        [titleLabel, countLabel].forEach {
            img.addSubview($0)
        }
    }
    
    private func layout() {
        img.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(17.4)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(17.4)
        }
    }
    
    private func binding() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        layout()
        applyShadow()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
