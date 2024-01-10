//
//  DayCaratLabel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

enum DayCaratFontType {
    case Header1
    case Header2
    case Header3
    case Header4
    case Header5
    case Header6
    case Subhead1
    case Subhead2
    case Subhead3
    case Subhead4
    case Subhead5
    case Subhead6

    case Body1
    case Body2
    case Body3
    case Body4
    case Body5
    
    case Caption1
    case Caption2
    case Caption3
}
/// DayCarat 디자인시스템 커스텀 라벨 입니다.
final class DayCaratLabel:UILabel {
    
    convenience init(type: DayCaratFontType, text: String = "", textColor: UIColor = .gray100) {
        self.init()
        configure(type: type, text: text, textColor: textColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure(type: DayCaratFontType, text: String, textColor: UIColor) {
        self.text = text
        self.textColor = textColor
        self.numberOfLines = 0
        self.sizeToFit()
        
        switch type {
        case .Header1:
            self.font = .pretendard(.Bold, size: 64)
        case .Header2:
            self.font = .pretendard(.Bold, size: 48)
        case .Header3:
            self.font = .pretendard(.Bold, size: 40)
        case .Header4:
            self.font = .pretendard(.Bold, size: 36)
        case .Header5:
            self.font = .pretendard(.Bold, size: 32)
        case .Header6:
            self.font = .pretendard(.Bold, size: 28)
        case .Subhead1:
            self.font = .pretendard(.Bold, size: 24)
        case .Subhead2:
            self.font = .pretendard(.Bold, size: 20)
        case .Subhead3:
            self.font = .pretendard(.SemiBold, size: 20)
        case .Subhead4:
            self.font = .pretendard(.Bold, size: 16)
        case .Body1:
            self.font = .pretendard(.Medium, size: 16)
        case .Body2:
            self.font = .pretendard(.Medium, size: 14)
        case .Body3:
            self.font = .pretendard(.Regular, size: 14)
        case .Body4:
            self.font = .pretendard(.SemiBold, size: 12)
        case .Body5:
            self.font = .pretendard(.Regular, size: 12)
        case .Caption1:
            self.font = .pretendard(.Medium, size: 12)
        case .Caption2:
            self.font = .pretendard(.SemiBold, size: 10)
        case .Caption3:
            self.font = .pretendard(.Medium, size: 10)
        case .Subhead6:
            self.font = .pretendard(.SemiBold, size: 16)
        case .Subhead5:
            self.font = .pretendard(.Bold, size: 16)
        }
    }
}
