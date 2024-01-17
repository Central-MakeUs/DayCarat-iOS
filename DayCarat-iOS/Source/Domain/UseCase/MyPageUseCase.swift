//
//  MyPageUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import RxSwift

protocol MyPageUseCaseProtocol {
    func fetchUserInfo() -> Single<BaseResponse<UserDTO>>
}
final class MyPageUseCase: MyPageUseCaseProtocol {
    
    private let repository: UserInterface
    
    init(repository: UserInterface) {
        self.repository = repository
    }
    
    func fetchUserInfo() -> RxSwift.Single<BaseResponse<UserDTO>> {
        return repository.fetchUserInfo()
    }
}
