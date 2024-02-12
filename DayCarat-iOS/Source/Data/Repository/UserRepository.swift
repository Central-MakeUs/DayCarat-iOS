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
    func patchUser(nickname: String?, jobTitle: String?, strength: String?, pushAllow: Bool?, fcmToken: String?) -> RxSwift.Single<BaseResponse<Bool>> {
        return service.patchUser(nickname: nickname, jobTitle: jobTitle, strength: strength, pushAllow: pushAllow, fcmToken: fcmToken)
    }
    
    func deleteUser() -> RxSwift.Single<BaseResponse<Bool>> {
        service.deleteUser()
    }
    
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
