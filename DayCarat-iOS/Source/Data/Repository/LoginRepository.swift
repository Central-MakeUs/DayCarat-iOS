//
//  LoginRepository.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import RxSwift

final class LoginRepository: LoginInterface {
    
    let service: LoginService
    
    init(service: LoginService) {
        self.service = service
    }
    
    func login(token: String) -> RxSwift.Single<BaseResponse<LoginResponse>> {
        return service.requestLogin(accessToken: token)
    }
}
