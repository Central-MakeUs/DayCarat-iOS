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
    
    func fetchGemKeywordCount() -> Single<BaseResponse<GemKeywordDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.kewortSortGemCount)
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<GemKeywordDTO>.self)
                .subscribe(onSuccess: {  res in
                    single(.success(res))
                }, onFailure: {  error in
                    print("api요청에러 보석 키워드 \(error)")
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchKeywordGemList(keyword: String) -> Single<BaseArrayResponse<GemKeywordEpi>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.keywordGemInfo(keyword: keyword))
                .filterSuccessfulStatusCodes()
                .map(BaseArrayResponse<GemKeywordEpi>.self)
                .subscribe(onSuccess: {  res in
                    print(res)
                    single(.success(res))
                }, onFailure: {  error in
                    print("api요청에러 보석 키워드별 리스트 \(error)")
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func patchSoara(episodeId: Int, content1: String? = nil, content2: String? = nil, content3: String? = nil, content4: String? = nil, content5: String? = nil) -> Single<BaseResponse<Bool>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.patchSoara(episodeId: episodeId, content1: content1, content2: content2, content3: content3, content4: content4, content5: content5))
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<Bool>.self)
                .subscribe(onSuccess: {  res in
                    single(.success(res))
                }, onFailure: {  error in
                    print("api요청에러 소아라 입력 \(error)")
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchSoaraData(episodeId: Int) -> Single<BaseResponse<SoaraInputDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.fetchSoara(episodeId: episodeId))
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<SoaraInputDTO>.self)
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
    
    func registerGem(episodeId: Int) -> Single<BaseResponse<Bool>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.gemRegister(episodeId: episodeId))
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<Bool>.self)
                .subscribe(onSuccess: {  res in
                    single(.success(res))
                }, onFailure: {  error in
                    print("보석등록에러===============\(error)")
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
    
    func fetchAiRecommand(episodeId: Int) -> Single<BaseResponse<AiRecommandDTO>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.aiRecommend(episodeId: episodeId))
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<AiRecommandDTO>.self)
                .subscribe(onSuccess: {  res in
                    single(.success(res))
                }, onFailure: {  error in
                    print("Ai추천문장에러======\(error)")
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }
    }
}
