//
//  Moya.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/16/24.
//

import Foundation
import UIKit

import Moya

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
    case keywordGemInfo(keyword: String) //키워드별 보석리스트 조회
    case episodeClipboard(episodeId: Int)  // 에피소드 복붙
    case episodeSoara(episodeId: Int)  //에피소드 소아라 조회 -> 보석만들기전 소아라만 입력
    case aiRecommend(episodeId: Int)  // AI추천 문장 및 키워드 조회
    case patchEpiKeyword(episodeId: Int, keyword: String) // 에피소드 키워드 수정
    case patchSoara(episodeId: Int, content1: String? = nil, content2: String? = nil, content3: String? = nil, content4: String? = nil, content5: String? = nil) // 소아라 입력
    case gemRegister(episodeId: Int) // 보석등록
    case allEpiCount // 전체 에피소드 갯수
    case userImg(img: UIImage) // 유저 프사등록
    case epiActivityTag(tag: String) // 활동별 에피소드 리스트 조회
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
        case .keywordGemInfo(keyword: let keyword):
            return "gem/keyword/\(keyword)"
        case .episodeClipboard(episodeId: let episodeId):
            return "gem/episode/\(episodeId)"
        case .episodeSoara(episodeId: let episodeId):
            return "gem/soara/\(episodeId)"
        case .patchEpiKeyword:
            return "episode/keyword"
        case .aiRecommend(episodeId: let episodeId):
            return "gem/recommend/\(episodeId)"
        case .patchSoara:
            return "gem/soara"
        case .gemRegister:
            return "gem/register"
        case .allEpiCount:
            return "episode/count/all"
        case .userImg:
            return "user/profile"
        case .epiActivityTag(tag: let tag):
            return "episode/count/activity/\(tag)?pageSize=12"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .epiRegister,
             .gemRegister,
             .userImg:
            return .post
        case .patchEpiKeyword,
             .patchSoara:
            return .patch
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .userImg(let img):
            let jpegData = img.jpegData(compressionQuality: 1.0)!
            let formData: [MultipartFormData] = [
                .init(provider: .data(jpegData), name: "multipartFile", fileName: "filename.jpeg", mimeType: "image/jpeg")
            ]
            return .uploadMultipart(formData)
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
        case .patchSoara(let episodeId, let content1, let content2, let content3, let content4, let content5):
            var parameters: [String: Any] = ["episodeId": episodeId]
            if let content1 = content1 {
                parameters["content1"] = content1
            }
            if let content2 = content2 {
                parameters["content2"] = content2
            }
            if let content3 = content3 {
                parameters["content3"] = content3
            }
            if let content4 = content4 {
                parameters["content4"] = content4
            }
            if let content5 = content5 {
                parameters["content5"] = content5
            }
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .userImg:
            guard let accessToken = UserDefaults.standard.string(forKey: "accessToken") else {
                return nil
            }
            return ["Authorization": "Bearer \(accessToken)", "Content-Type": "multipart/form-data"]
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
