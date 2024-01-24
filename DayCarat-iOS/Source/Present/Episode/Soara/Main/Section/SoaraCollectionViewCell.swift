//
//  SoaraCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/22/24.
//

import UIKit

final class SoaraCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SoaraCollectionViewCell"
    
    private let titleLabel = DayCaratLabel(type: .Body2, text: "", textColor: .black)
    private let img = UIImageView().then {
        $0.image = UIImage(named: "icon-chevron-right")
        $0.tintColor = .Gray800!
    }
    
    private func layout() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.Gray300?.cgColor
        img.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11)
            $0.trailing.equalToSuperview().inset(13)
            $0.height.width.equalTo(24)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.verticalEdges.equalToSuperview().inset(11)
        }
    }
    
    func configureCell(text: String) {
        self.titleLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        [titleLabel, img].forEach {
            self.addSubview($0)
        }
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
