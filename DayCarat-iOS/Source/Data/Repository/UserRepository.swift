//
//  UserRepository.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import Foundation
import UIKit

import RxSwift

final class UserRepository: UserInterface {
    
    private let service: UserInfoService
    
    init(service: UserInfoService) {
        self.service = service
    }
    
    func fetchUserInfo() -> RxSwift.Single<BaseResponse<UserDTO>> {
        return service.fetchUserInfo()
    }
    
    func uploadUserProfileImg(img: UIImage) -> RxSwift.Single<BaseResponse<Bool>> {
        return service.uploadUserProfileImg(img: img)
    }
}
