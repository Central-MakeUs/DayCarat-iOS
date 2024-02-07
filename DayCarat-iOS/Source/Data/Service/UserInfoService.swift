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
    private let provider = MoyaProvider<DayCaratTarget>(plugins: [NetworkLoggerPlugin()])
    
    func fetchUserInfo() -> Single<BaseResponse<UserDTO>> {
        return Single.create { single in
            let disposable = self.provider.rx
                .request(.userInfo)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<UserDTO>.self)
                .subscribe(onSuccess: { response in
                    single(.success(response))
                }, onFailure: { error in
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
    
}
