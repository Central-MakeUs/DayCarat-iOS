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
    case epiRegister(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) // 에피소드 등록
    case monthGem  //한달 보석갯수
    case totalGemCount  // 총 보석갯수
    case keywordMostGem // 가장 보석 많은 키워드
    case activityMostGem  //가장 보석 많은 활동
    case kewortSortGemCount // 키워드별 보석갯수
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
        case .monthGem:
            return "gem/report/month-count"
        case .totalGemCount:
            return "gem/count"
        case .keywordMostGem:
            return "gem/report/keyword"
        case .activityMostGem:
            return "gem/report/activity"
        case .kewortSortGemCount:
            return "gem/keyword"
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
         .activityTag,
         .monthGem,
         .totalGemCount,
         .keywordMostGem,
         .activityMostGem,
         .kewortSortGemCount:
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
        case .epiRegister(let title, let date, let activityTag, let episodeContents):
            let contentsArray = episodeContents.map { content in
                     return [
                         "episodeContentType": content.episodeContentType,
                         "content": content.content
                     ]
                 }
                 let parameters: [String: Any] = [
                     "title": title,
                     "date": date,
                     "activityTag": activityTag,
                     "episodeContents": contentsArray
                 ]
                 return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .login(_):
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
