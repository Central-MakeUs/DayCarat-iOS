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
    case monthEpiCount // 이번달 에피소드 갯수 조회
    case detailEpi(episodeId: Int)  // 에피소드 상세
    case recentEpi  // 최근 에피소드 3개
    case lastestEpi(year: Int) //에피소드 조회: 최신순
    case activtyEpi //에피소드 조회: 활동순
    case userInfo  // 유저정보 조회
    case activityTag //활동 태그조회
    case epiRegister(episodeContentType: String, content: String) // 에피소드 등록
}

extension DayCaratTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.daycarat.shop/api/")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "user/oauth/kakao"
        case .monthEpiCount:
            return "episode/count"
        case .recentEpi:
            return "episode/recent"
        case .lastestEpi:
            return "episode/date"
        case .activtyEpi:
            return "episode/activity"
        case .userInfo:
            return "user/userInfo"
        case .activityTag:
            return "activity"
        case .detailEpi(episodeId: let episodeId):
            return "episode/\(episodeId)"
        case .epiRegister:
            return "episode/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login,
         .monthEpiCount,
         .detailEpi,
         .recentEpi,
         .lastestEpi,
         .activtyEpi,
         .userInfo,
         .activityTag:
            return .get
        case .epiRegister:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .login(let accessToken):
            let parameters: [String: Any] = ["accessToken": accessToken]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .lastestEpi(let year):
            let parameters: [String: Any] = ["year": year]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .epiRegister(let episodeContentType, let content):
            let parameters: [String: Any] = ["episodeContentType": episodeContentType, "content": content]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .login(let accessToken):
            return ["Content-Type": "application/json"]
        default:
            guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
                return nil
            }
            return ["Authorization": "Bearer \(accessToken)", "Content-Type": "application/json"]
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
