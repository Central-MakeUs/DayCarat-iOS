//
//  MyPageViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    private let profileImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 35
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.Gray200?.cgColor
    }
    private let nickNameLabel = DayCaratLabel(type: .Subhead3, text: "지철", textColor: .black)
    private let emailLabel = DayCaratLabel(type: .Body5, text: "sksk02zja@naver.com", textColor: .Gray600!)
    
    override func configure() {

    }
    
    override func addView() {
        [profileImg, nickNameLabel, emailLabel].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        profileImg.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(113)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(72)
        }
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImg.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func binding() {
        
    }
}
