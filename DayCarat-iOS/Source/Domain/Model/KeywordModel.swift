//
//  KeywordModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/29/24.
//

import Foundation
import UIKit

import RxCocoa
import RxDataSources



struct GemKeywordSection {
    var items: [Item]
}

extension GemKeywordSection: SectionModelType {
    typealias Item = GemKeywordEpi

    init(original: GemKeywordSection, items: [Item]) {
        self = original
        self.items = items
    }
}


struct GemSection {
    var items: [Item]
}

extension GemSection: SectionModelType {
    typealias Item = GemKeywordInfo

    init(original: GemSection, items: [Item]) {
        self = original
        self.items = items
    }
}

struct GemKeywordInfo {
    let keyword: KeywordEnum
    let count: Int
    let title: String
    let image: UIImage?
}

enum KeywordEnum {
    case communication // 커뮤니케이션
    case problemSolving  // 문제해결능력
    case creativity  // 창의성
    case challengeSpirit  // 도전정신
    case proficiency  //전문성
    case execution  // 실행력
    case unset  // 미선택
    
    var gemTitle: String {
        switch self {
        case .communication:
            return "커뮤니케이션"
        case .problemSolving:
            return "문제 해결"
        case .creativity:
            return "창의성"
        case .challengeSpirit:
            return "도전 정신"
        case .proficiency:
            return "전문성"
        case .execution:
            return "실행력"
        case .unset:
            return "미선택"
        }
    }

    var gemImg: UIImage? {
        switch self {
        case .communication:
            return UIImage(named: "Jewelry")!
        case .problemSolving:
            return UIImage(named: "문제해결보석")!
        case .creativity:
            return UIImage(named: "창의성보석")!
        case .challengeSpirit:
            return UIImage(named: "도전정신보석")!
        case .proficiency:
            return UIImage(named: "전문성보석")!
        case .execution:
            return UIImage(named: "실행력보석")!
        case .unset:
            return nil
        }
    }
}
extension KeywordEnum {
    static var allCases: [KeywordEnum] {
        return [.communication, .problemSolving, .creativity, .challengeSpirit, .proficiency, .execution, .unset]
    }
}

