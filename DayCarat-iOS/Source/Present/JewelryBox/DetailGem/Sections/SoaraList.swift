//
//  SoaraList.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/11/24.
//

import UIKit

final class SoaraList: UICollectionViewCell {
    static let identifier = "SoaraList"
    
    private let titleLabel = DayCaratLabel(type: .Subhead5, text: "", textColor: .Main!)
    private let subTitleLabel = DayCaratLabel(type: .Subhead5, text: "", textColor: .black)
    let desLabel = DayCaratLabel(type: .Body2, text: "", textColor: .Gray600!)

    
    private func addView() {
        [titleLabel, subTitleLabel, desLabel].forEach {
            self.addSubview($0)
        }
    }
    func configureDes(title: String, subtitle: String, des: String) {
        self.desLabel.text = des
        self.subTitleLabel.text = subtitle
        self.titleLabel.text = title
    }
    
    private func layout() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.Gray200?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(20)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(UIScreen.main.bounds.size.width - 50)
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
