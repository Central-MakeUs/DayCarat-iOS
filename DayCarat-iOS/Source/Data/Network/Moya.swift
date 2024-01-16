//
//  Moya.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/16/24.
//

import Moya
import Foundation

enum DayCaratTarget {
    case login(accessToken: String)
}

extension DayCaratTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.daycarat.shop/api/")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "user/oauth/kakao"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let accessToken):
            let parameters: [String: Any] = ["accessToken": accessToken]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
