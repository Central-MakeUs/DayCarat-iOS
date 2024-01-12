//
//  CustomNavigaitonBar.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/10/24.
//

import UIKit

import SnapKit
import Then

@objc
protocol CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar:CustomNavigaitonBar)
    func rightBtnClick(_ navibar:CustomNavigaitonBar)
}
final class CustomNavigaitonBar: UIView {
    
    weak var delegate: CustomNavigaitonBarDelegate?

    private let backBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .black
    }
    private let titleLabel = DayCaratLabel(type: .Subhead6, text: "", textColor: .black)
    private var rightBtn = UIButton().then {
        $0.setTitleColor(.Main, for: .normal)
        $0.tintColor = .Gray800
    }
    
    convenience init(btnstate: Bool, rightBtnText: String = "", middleText: String = "") {
        self.init(frame: .zero)
        configure(btnstate: btnstate, rightBtnText: rightBtnText, middleText: middleText)
        addView()
        layout()
    }
    
    private func configure(btnstate: Bool, rightBtnText: String = "", middleText: String = "") {
        self.backgroundColor = UIColor(hexString: "#F9F9F9")
        titleLabel.text = middleText
        if btnstate {
            rightBtn.setTitle(rightBtnText, for: .normal)
            rightBtn.isHidden = false
        }
        else {
            rightBtn.isHidden = true
        }
        self.backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.rightBtn.addTarget(self, action: #selector(rightBtnClick), for: .touchUpInside)
    }
    
    private func addView() {
        [backBtn, titleLabel, rightBtn].forEach {
            self.addSubview($0)
        }
    }
    
    private func layout() {
        backBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(24)
        }
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        rightBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
extension CustomNavigaitonBar {
    @objc func backBtnClick(){
        self.delegate?.backBtnClick(self)
    }
    @objc func rightBtnClick(){
        self.delegate?.rightBtnClick(self)
    }
}
