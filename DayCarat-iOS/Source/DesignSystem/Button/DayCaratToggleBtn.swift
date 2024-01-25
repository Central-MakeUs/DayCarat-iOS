//
//  DayCaratToggleBtn.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/25.
//

import UIKit


enum toggleState {
    case Enabled
    case Disabled
}

///DayCarat 디자인시스템 커스텀 토글버튼입니다.
final class DayCaratToggleBtn: UIButton {
    
    convenience init(text: String = "") {
        self.init(frame: .zero)
        configure(text: text)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var isEnabled: Bool {
        didSet {
            updateUIForEnabledState()
        }
    }

    private func updateUIForEnabledState() {
        if isEnabled {
            // 버튼이 활성화된 경우
            self.backgroundColor = .white
            self.layer.borderColor = UIColor.Main?.cgColor
            self.layer.borderWidth = 1
            self.setTitleColor(.Main, for: .normal)
        } else {
            // 버튼이 비활성화된 경우
            self.backgroundColor = .Gray100
            self.setTitleColor(.Gray400, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure(text: String) {
        self.setTitle(text, for: .normal)
        self.layer.cornerRadius = 18
        self.titleLabel?.font = .pretendard(.SemiBold, size: 13)
    }
}
