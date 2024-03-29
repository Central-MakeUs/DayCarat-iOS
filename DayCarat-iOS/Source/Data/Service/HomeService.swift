//
//  HomeService.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import Foundation

import Moya
import RxMoya
import RxSwift

class HomeService {
    private let bag = DisposeBag()
    private let provider = MoyaProvider<DayCaratTarget>()

    func requestMontEpi() -> Single<BaseResponse<epiCount>> {
        return Single.create { single in
            let disposable = self.provider.rx
                .request(.monthEpiCount)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<epiCount>.self)
                .subscribe(onSuccess: { response in
                    print("이번달갯수=======\(response)")

                    single(.success(response))
                }, onFailure: { error in
                    print("이번달갯수=======\(error)")
                    single(.failure(error))
                })

            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchRecentEpi() -> Single<BaseArrayResponse<recentEPi>> {
        return Single.create { single in
            let disposable = self.provider.rx
                .request(.recentEpi)
                .filterSuccessfulStatusCodes()
                .map(BaseArrayResponse<recentEPi>.self)
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
}
