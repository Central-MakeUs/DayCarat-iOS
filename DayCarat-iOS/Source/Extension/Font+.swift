//
//  Font+.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

extension UIFont {
    public enum PretendardType: String {
        case Black = "Black"
        case Bold = "Bold"
        case Medium = "Medium"
        case Regular = "Regular"
        case ExtraBold = "ExtraBold"
        case Heavy = "Heavy"
        case Light = "Light"
        case ExtraLight = "ExtraLight"
        case Thin = "Thin"
        case SemiBold = "SemiBold"
    }
    
    static func pretendard(_ type: PretendardType, size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-\(type.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}
