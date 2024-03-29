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
                    print("==========등록성공========")
                }, onFailure: { error in
                    single(.failure(error))
                    print("==========등록실패========")

                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchActivityEpiList() -> Single<BaseArrayResponse<ActivityEpiQuantityDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.activtyEpi)
                .filterSuccessfulStatusCodes()
                .map(BaseArrayResponse<ActivityEpiQuantityDTO>.self)
                .subscribe(onSuccess: { response in
                    print(response)
                    single(.success(response))
                }, onFailure: { error in
                    print(error)
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchDateEpiList() -> Single<BaseArrayResponse<DateEpiQuantityDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.lastestEpi(year: 2024))
                .filterSuccessfulStatusCodes()
                .map(BaseArrayResponse<DateEpiQuantityDTO>.self)
                .subscribe(onSuccess: { response in
                    print(response)
                    single(.success(response))
                }, onFailure: { error in
                    print(error)
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchDetailEpi(episodeId: Int) -> Single<BaseResponse<DetailEpisodeDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.detailEpi(episodeId: episodeId))
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<DetailEpisodeDTO>.self)
                .subscribe(onSuccess: { response in
                    print("=======디테일\(response)")
                    single(.success(response))
                }, onFailure: { error in
                    print("Debug=====\(error)")
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchEpiAllCount() -> Single<BaseResponse<epiCount>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.allEpiCount)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<epiCount>.self)
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
    
    func fetchActivityEpiList(activity: String) -> Single<BaseArrayResponse<ActivityEpisodeList>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.epiActivityTag(tag: activity))
                .filterSuccessfulStatusCodes()
                .map(BaseArrayResponse<ActivityEpisodeList>.self)
                .subscribe(onSuccess: { response in
                    single(.success(response))
                }, onFailure: { error in
                    print("Debug=====\(error)")
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchEpiDate() -> Single<BaseArrayResponse<DateEpiQuantityDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.lastestEpi(year: 2024))
                .filterSuccessfulStatusCodes()
                .map(BaseArrayResponse<DateEpiQuantityDTO>.self)
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
