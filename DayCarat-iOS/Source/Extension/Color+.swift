//
//  Color+.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

extension UIColor {
    
    // MARK: - Extension

    convenience init(hexString: String) {     /// hex값 사용
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }
    
    // MARK: - Color

    static let Gray50 = UIColor(named: "Gray50")
    static let Gray100 = UIColor(named: "Gray100")
    static let Gray200 = UIColor(named: "Gray200")
    static let Gray300 = UIColor(named: "Gray300")
    static let Gray400 = UIColor(named: "Gray400")
    static let Gray500 = UIColor(named: "Gray500")
    static let Gray600 = UIColor(named: "Gray600")
    static let Gray700 = UIColor(named: "Gray700")
    static let Gray800 = UIColor(named: "Gray800")
    static let Gray900 = UIColor(named: "Gray900")
    
    static let Main = UIColor(named: "Main")
    static let Main50 = UIColor(named: "Main50")
    static let Main100 = UIColor(named: "Main100")
    static let Main200 = UIColor(named: "Main200")
    static let Main300 = UIColor(named: "Main300")
    static let Main400 = UIColor(named: "Main400")
    static let Main600 = UIColor(named: "Main600")
    static let Main700 = UIColor(named: "Main700")
    static let Main800 = UIColor(named: "Main800")
    static let Main900 = UIColor(named: "Main900")
    
    static let SubBlue = UIColor(named: "Sub blue")
    static let SubBlue50 = UIColor(named: "Sub blue50")
    static let SubBlue100 = UIColor(named: "Sub blue100")
    static let SubBlue200 = UIColor(named: "Sub blue200")
    static let SubBlue300 = UIColor(named: "Sub blue300")
    static let SubBlue400 = UIColor(named: "Sub blue400")

    static let SubPink = UIColor(named: "Sub pink")
    static let SubPink50 = UIColor(named: "Sub pink50")
    static let SubPink100 = UIColor(named: "Sub pink100")
    static let SubPink200 = UIColor(named: "Sub pink200")
    static let SubPink300 = UIColor(named: "Sub pink300")
    static let SubPink400 = UIColor(named: "Sub pink400")
}
