//
//  IntroCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/8/24.
//

import UIKit

final class IntroCollectionViewCell: UICollectionViewCell {
    static let identifier = "IntroCollectionViewCell"

    private lazy var titleLabel = DayCaratLabel(type: .Header6, textColor: .black)
    private lazy var desLabel = DayCaratLabel(type: .Body3, textColor: .Gray500!)
    private let img = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    func configureCell(titleLabel: String, desLabel: String, img: UIImage?) {
        // Configure your cell UI elements with titleLabel, desLabel, and img
        self.titleLabel.text = titleLabel
        self.desLabel.text = desLabel

        // Check if img is not nil before using it
        if let img = img {
            self.img.image = img
        } else {
            self.img.image = UIImage(systemName: "folder")
        }
    }
    
    private func layout() {
        [titleLabel, desLabel, img].forEach {
            self.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)

        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        img.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(230)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        self.backgroundColor = .clear
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
