//
//  MyPageModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2/6/24.
//

import Foundation

import RxDataSources

enum MyPageModel {
    case logout
    case delete
    
    var title: String {
        switch self {
        case .logout:
            return "로그아웃"
        case .delete:
            return "회원탈퇴"
        }
    }
}
extension MyPageModel {
    static var allCases: [MyPageModel] {
        return [.logout, .delete]
    }
}
