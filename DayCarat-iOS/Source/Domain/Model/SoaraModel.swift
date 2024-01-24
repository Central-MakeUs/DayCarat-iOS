//
//  SoaraModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/24.
//

import RxSwift
import RxCocoa

enum SoaraType {
    case S
    case O
    case A
    case R
    case LastA
    
    var title: Driver<String> {
        switch self {
        case .S:
            return Driver.just("어떤 상황 또는 어떤 문제였나요?")
        case .O:
            return Driver.just("당시 무엇을 성취하는 것이 목표였나요?")
        case .A:
            return Driver.just("목표를 위해 구체적으로 어떤 행동을 하였나요?")
        case .R:
            return Driver.just("그로 인해 어떤 결과가 발생했나요?")
        case .LastA:
            return Driver.just("그 결과가 내게 미친 영향은 무엇인가요?")
        }
    }
}
extension SoaraType {
    static var allCases: [SoaraType] {
        return [.S, .O, .A, .R, .LastA]
    }
}

struct SoaraModel {
//    var type: SoaraType
//    var title: Driver<String> {
//        return type.title
//    }
    let soaraCells: Driver<[String]> = Driver.just([
        "어떤 상황 또는 어떤 문제였나요?",
        "당시 무엇을 성취하는 것이 목표였나요?",
        "목표를 위해 구체적으로 어떤 행동을 하였나요?",
        "그로 인해 어떤 결과가 발생했나요?",
        "그 결과가 내게 미친 영향은 무엇인가요?"
    ])
}

