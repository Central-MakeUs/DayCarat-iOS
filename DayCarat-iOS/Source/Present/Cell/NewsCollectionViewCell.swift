//
//  NewsCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

import RxSwift

final class NewsCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    var disposeBag = DisposeBag()
    
    private let Img = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    }
    private let textLabel = DayCaratLabel(type: .Body2, text: "AI를 활용한\n자기소개하기", textColor: .black)
    
    func configureCell(img: String) {
        self.Img.image = UIImage(named: img)
    }
    
    private func applyShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.Gray600?.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 3
    }

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray100.cgColor
        self.layer.cornerRadius = 8
        applyShadow()
        self.addSubview(Img)
        self.addSubview(textLabel)

        Img.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(111)
        }
        textLabel.snp.makeConstraints {
            $0.top.equalTo(Img.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
