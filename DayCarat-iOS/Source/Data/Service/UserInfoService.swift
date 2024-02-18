//
//  UserInfoService.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import Foundation
import UIKit

import RxSwift
import Moya

class UserInfoService {
    
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<DayCaratTarget>()
    
    func fetchUserInfo() -> Single<BaseResponse<UserDTO>> {
        return Single.create { single in
            let disposable = self.provider.rx
                .request(.userInfo)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<UserDTO>.self)
                .subscribe(onSuccess: { response in
                    single(.success(response))
                    print("====유저정보\(response)")
                }, onFailure: { error in
                    print("====유저정보에러\(error)")
                    single(.failure(error))
                })

            return Disposables.create {
                disposable.dispose()
            }
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
    }
    
    func uploadUserProfileImg(img: UIImage) -> Single<BaseResponse<Bool>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.userImg(img: img))
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<Bool>.self)
                .subscribe(onSuccess: { response in
                    single(.success(response))
                }, onFailure: { error in
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    func deleteUser() ->  Single<BaseResponse<Bool>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.userDelete)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<Bool>.self)
                .subscribe(onSuccess: { response in
                    single(.success(response))
                    print("회원탈퇴성공")
                }, onFailure: { error in
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    func patchUser(nickname: String? = nil, jobTitle: String? = nil, strength: String? = nil, pushAllow: Bool? = nil, fcmToken: String? = nil) ->  Single<BaseResponse<Bool>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.patchUserInfo(nickname: nickname, jobTitle: jobTitle, strength: strength, pushAllow: pushAllow, fcmToken: fcmToken))
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<Bool>.self)
                .subscribe(onSuccess: { response in
                    single(.success(response))
                }, onFailure: { error in
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
