//
//  SecondIntroPage.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/7/24.
//

import UIKit

class SecondIntroPage: BaseView {
    private let titleLabel = DayCaratLabel(type: .Header6, text: "경험들을 다듬어\n보석으로", textColor: .black)
    private let desLabel = DayCaratLabel(type: .Body2, text: "어쩌구저쩌구\n설명", textColor: .gray500)
    
    override func configure() {
        
    }
    
    override func addview() {
        [titleLabel, desLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
    }
}
