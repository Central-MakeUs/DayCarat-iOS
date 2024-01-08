//
//  DayCaratBtn.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

enum BtnState {
    case Default
    case Disabled
    case Jump
}
///DayCarat 디자인시스템 커스텀 버튼입니다.
final class DayCaratBtn: UIButton {
    
    convenience init(type: BtnState, text: String = "") {
        self.init(frame: .zero)
        configure(type: type, text: text)
        translatesAutoresizingMaskIntoConstraints = false
        snp.makeConstraints {
            $0.width.equalTo(360)
            $0.height.equalTo(48)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateUIForEnabledState()
        }
    }

    private func updateUIForEnabledState() {
        if isEnabled {
            // 버튼이 활성화된 경우
            self.backgroundColor = .Main
            self.setTitleColor(.white, for: .normal)
        } else {
            // 버튼이 비활성화된 경우
            self.backgroundColor = .Gray300
            self.setTitleColor(.Gray600, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure(type: BtnState, text: String) {
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 8
        self.titleLabel?.font = .pretendard(.SemiBold, size: 16)
        switch type {
            
        case .Default:
            self.backgroundColor = .Main
            self.setTitleColor(.white, for: .normal)
        case .Disabled:
            self.backgroundColor = .Gray300
            self.setTitleColor(.Gray600, for: .normal)
            self.isEnabled = false
        case .Jump:
            self.backgroundColor = .white
            self.setTitleColor(.Main, for: .normal)
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.Main?.cgColor
        }
    }
}
