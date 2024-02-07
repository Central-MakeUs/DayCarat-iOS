//
//  MyPageUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//
import UIKit

import RxSwift

protocol MyPageUseCaseProtocol {
    func fetchUserInfo() -> Single<BaseResponse<UserDTO>>
    func uploadUserProfileImg(img: UIImage) -> Single<BaseResponse<Bool>>
}
final class MyPageUseCase: MyPageUseCaseProtocol {
    
    private let repository: UserInterface
    
    init(repository: UserInterface) {
        self.repository = repository
    }
    
    func fetchUserInfo() -> RxSwift.Single<BaseResponse<UserDTO>> {
        return repository.fetchUserInfo()
    }
    
    func uploadUserProfileImg(img: UIImage) -> RxSwift.Single<BaseResponse<Bool>> {
        return repository.uploadUserProfileImg(img: img)
    }
}
