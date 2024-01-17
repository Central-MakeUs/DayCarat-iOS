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
        return provider.rx
            .request(.monthEpiCount)
            .filterSuccessfulStatusCodes()
            .map(BaseResponse<epiCount>.self)
            .do(onSuccess: { response in
                print(response)
            }, onError: { error in
                if let moyaError = error as? MoyaError,
                   case let .statusCode(response) = moyaError {
                    let data = response.data
                    if let errorMessage = String(data: data, encoding: .utf8) {
                        print("Alamofire Error: \(errorMessage)")
                    }
                } else {
                    print("Moya Error: \(error)")
                }
            })
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
