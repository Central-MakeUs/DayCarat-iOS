//
//  JewelryViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

class JewelryViewController: BaseViewController {
    private let searchBtn = UIButton().then {
        $0.setImage(UIImage(named: "icon-search"), for: .normal)
        $0.tintColor = UIColor(hexString: "#2D3648")
    }
    private let titleLabel = DayCaratLabel(type: .Header5, text: "보석함", textColor: .Gray900!)
    
    private let profileView = UIView().then {
        $0.backgroundColor = .Main100
        $0.layer.cornerRadius = 16
    }
    
    private let nickNameLabel = DayCaratLabel(type: .Subhead6, text: "지철", textColor: .Main600!)
    private let strengthLabel = DayCaratLabel(type: .Body4, text: "빙수폭격기", textColor: .Main600!)

    private let jewelryView = UIView().then {
        $0.backgroundColor = .Main400
        $0.layer.cornerRadius = 16
    }
    
    private let profileImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.Gray200?.cgColor
    }

    override func configure() {
        self.view.backgroundColor = .Gray50
    }
    
    override func addView() {
        [searchBtn, titleLabel, profileView, jewelryView].forEach {
            self.view.addSubview($0)
        }
        [nickNameLabel, strengthLabel, profileImg].forEach {
            profileView.addSubview($0)
        }
    }
    
    override func layout() {
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(18)
            $0.trailing.equalToSuperview().offset(-16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        profileView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(174)
            $0.height.equalTo(97)
        }
        jewelryView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(28)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.equalTo(174)
            $0.height.equalTo(97)
        }
        profileImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(11)
            $0.height.width.equalTo(49)
        }
        nickNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalTo(profileImg.snp.trailing).offset(11)
        }
        strengthLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(1)
            $0.leading.equalTo(profileImg.snp.trailing).offset(11)
        }
    }
    
    override func binding() {
        
    }
}
