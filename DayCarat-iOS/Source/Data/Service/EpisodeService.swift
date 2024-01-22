//
//  EpisodeService.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import Foundation

import Moya
import RxMoya
import RxSwift

class EpisodeService {
    private let provider = MoyaProvider<DayCaratTarget>()
    
    func registerEpi(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) -> Single<BaseResponse<Bool>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.epiRegister(title: title, date: date, activityTag: activityTag, episodeContents: episodeContents))
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
