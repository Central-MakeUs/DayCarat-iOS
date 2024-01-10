//
//  JewelryHeaderView.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

import RxSwift
import RxCocoa

final class JewelryHeaderView: UICollectionReusableView {
    static let identifier = "JewelryHeaderView"
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
    private let jewelryViewTitleLabel = DayCaratLabel(type: .Subhead5, text: "나의 보석", textColor: .white)
    private let myJewelryCountLabel = DayCaratLabel(type: .Header2, text: "100", textColor: .white)
    private let myJewelryImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "whiteJewerly")
    }
    private let jewelryTitleLabel = DayCaratLabel(type: .Subhead3, text: "나의 보석", textColor: .Gray900!)
    private let reportTitleLabel = DayCaratLabel(type: .Subhead5, text: "이번달 보석함 리포트", textColor: .Gray50!)

    private let jewelryView = UIView().then {
        $0.backgroundColor = .Main400
        $0.layer.cornerRadius = 16
    }
    
    private let reportView = UIView().then {
        $0.backgroundColor = .Main200
        $0.layer.cornerRadius = 16
    }
    private let reporttLabel = DayCaratLabel(type: .Subhead5, text: "이번달 보석함 리포트", textColor: .white)
    private let reportSV = UIStackView().then {
        $0.spacing = 8
        $0.axis = .horizontal
    }
    private let reportJewelryView = UIView().then {
        $0.backgroundColor = .Gray50
        $0.layer.cornerRadius = 16
    }
    private let reportEpiView = UIView().then {
        $0.backgroundColor = .Gray50
        $0.layer.cornerRadius = 16
    }
    private let reportMonthView = UIView().then {
        $0.backgroundColor = .Gray50
        $0.layer.cornerRadius = 16
    }
    private let profileImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.Gray200?.cgColor
    }
    
    private func addView() {
        [searchBtn, titleLabel, profileView, jewelryView, jewelryTitleLabel, reportView].forEach {
            self.addSubview($0)
        }
        [nickNameLabel, strengthLabel, profileImg].forEach {
            profileView.addSubview($0)
        }
        [myJewelryImg, jewelryViewTitleLabel, myJewelryCountLabel].forEach {
            jewelryView.addSubview($0)
        }
        [reporttLabel, reportSV].forEach {
            reportView.addSubview($0)
        }
        [reportJewelryView, reportEpiView, reportMonthView].forEach {
            reportSV.addArrangedSubview($0)
        }
    }
    
    private func layout() {
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(18)
            $0.trailing.equalToSuperview().offset(-16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(52)
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
        jewelryViewTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }
        myJewelryCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(37)
            $0.trailing.equalToSuperview().inset(16)
        }
        myJewelryImg.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(18.4)
            $0.trailing.equalTo(myJewelryCountLabel.snp.leading)
            $0.width.equalTo(24)
            $0.height.equalTo(16.6)
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
        reportView.snp.makeConstraints {
            $0.top.equalTo(jewelryView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(160)
        }
        reporttLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }
        reportEpiView.snp.makeConstraints {
            $0.width.equalTo(104)
            $0.height.equalTo(96)
        }
        reportMonthView.snp.makeConstraints {
            $0.width.equalTo(104)
            $0.height.equalTo(96)
        }
        reportJewelryView.snp.makeConstraints {
            $0.width.equalTo(104)
            $0.height.equalTo(96)
        }
        reportSV.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
        jewelryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(reportView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    func congiureview() {
        
    }
    
    private func binding() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        layout()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
