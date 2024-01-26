//
//  GemService.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import RxSwift
import Moya
import RxCocoa

class GemService {
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<DayCaratTarget>()
    
    func fetchMonthGemCount() -> Single<BaseResponse<GemCountDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.monthGem)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<GemCountDTO>.self)
                .subscribe(onSuccess: {  res in
                    single(.success(res))
                }, onFailure: {  error in
                    print(error)
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchTotalGemCount() -> Single<BaseResponse<GemCountDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.totalGemCount)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<GemCountDTO>.self)
                .subscribe(onSuccess: {  res in
                    single(.success(res))
                }, onFailure: {  error in
                    print(error)
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchGemMostKeyword() -> Single<BaseResponse<GemMostKeyword>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.keywordMostGem)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<GemMostKeyword>.self)
                .subscribe(onSuccess: {  res in
                    single(.success(res))
                }, onFailure: {  error in
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchGemMostActivityTag() -> Single<BaseResponse<GemMostActivityDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.activityMostGem)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<GemMostActivityDTO>.self)
                .subscribe(onSuccess: {  res in
                    single(.success(res))
                }, onFailure: {  error in
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
