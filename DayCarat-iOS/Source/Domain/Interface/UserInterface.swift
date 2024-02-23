//
//  UserInterface.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import Foundation
import UIKit

import RxSwift
 
protocol UserInterface {
    func fetchUserInfo() -> Single<BaseResponse<UserDTO>>
    func uploadUserProfileImg(img: UIImage) -> Single<BaseResponse<Bool>>
    func deleteUser() ->  Single<BaseResponse<Bool>>
    func patchUser(nickname: String?, jobTitle: String?, strength: String?, pushAllow: Bool?, fcmToken: String?) ->  Single<BaseResponse<Bool>>
}
