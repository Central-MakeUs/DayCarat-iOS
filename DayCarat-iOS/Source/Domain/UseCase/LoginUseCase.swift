//
//  LoginUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import RxSwift

protocol LoginUseCaseProtocol {
    func login(token: String) -> Single<BaseResponse<LoginResponse>>
}
final class LoginUseCase: LoginUseCaseProtocol {
    
    let repository: LoginInterface
    
    init(repository: LoginInterface) {
        self.repository = repository
    }
    
    func login(token: String) -> RxSwift.Single<BaseResponse<LoginResponse>> {
        return repository.login(token: token)
    }
}
