//
//  UserInterface.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import Foundation

import RxSwift
 
protocol UserInterface {
    func fetchUserInfo() -> Single<BaseResponse<UserDTO>>
}
