//
//  LoginInterface.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import RxSwift

protocol LoginInterface {
    func login(token: String) -> Single<BaseResponse<LoginResponse>>
}
