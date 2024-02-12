//
//  EpisodeUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/12.
//

import RxSwift
import RxCocoa

protocol EpisodeUseCaseProtocol {
    func getSoara() -> Driver<[SoaraType]>
    func registerEpi(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) -> Single<BaseResponse<Bool>>
    func fetchDetailEpi(episodeId: Int) -> RxSwift.Single<BaseResponse<DetailEpisodeDTO>>
    func fetchActivityEpiList() -> RxSwift.Single<BaseArrayResponse<ActivityEpiQuantityDTO>>
    func fetchEpiAllCount() -> Single<BaseResponse<epiCount>>
    func fetchActivityEpiList(activity: String) -> Single<BaseArrayResponse<ActivityEpisodeList>>
    func completeSoaraInput(type: SoaraType)
    func soaraInputObservable() -> Observable<SoaraType>
    func fetchSoaraData(episodeId: Int) -> Single<[SoaraType]>
    func getSoaraDetailData(episodeId: Int) -> Single<BaseResponse<SoaraInputDTO>>
}
final class EpisodeUseCase: EpisodeUseCaseProtocol {

    private let epiRepository: EpisodeRepository
    private let soaraInputSubject = PublishRelay<SoaraType>()
    private let gemRepository: GemRepository
    
    init(epiRepository: EpisodeRepository, gemRepository: GemRepository) {
        self.epiRepository = epiRepository
        self.gemRepository = gemRepository
    }
    
    //MARK: - Metod to Network

    func registerEpi(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) -> RxSwift.Single<BaseResponse<Bool>> {
        return epiRepository.registerEpi(title: title, date: date, activityTag: activityTag, episodeContents: episodeContents)
    }
    
    func fetchDetailEpi(episodeId: Int) -> RxSwift.Single<BaseResponse<DetailEpisodeDTO>> {
        return epiRepository.fetchDetailEpi(episodeId: episodeId)
    }
    
    func fetchEpiAllCount() -> RxSwift.Single<BaseResponse<epiCount>> {
        return epiRepository.fetchEpiAllCount()
    }
    
    func fetchActivityEpiList() -> RxSwift.Single<BaseArrayResponse<ActivityEpiQuantityDTO>> {
        return epiRepository.fetchActivityEpiList()
    }
    
    func fetchActivityEpiList(activity: String) -> RxSwift.Single<BaseArrayResponse<ActivityEpisodeList>> {
        return epiRepository.fetchActivityEpiList(activity: activity)
    }
    
    func fetchSoaraData(episodeId: Int) -> Single<[SoaraType]> {
        return gemRepository.fetchSoaraData(episodeId: episodeId)
            .map({  res in
                return res.result!.nonNullSoaraTypes
            })
    }
    
    func getSoaraDetailData(episodeId: Int) -> Single<BaseResponse<SoaraInputDTO>> {
        return gemRepository.fetchSoaraData(episodeId: episodeId)
    }
    //MARK: - Metod to Model
    
    func getSoara() -> Driver<[SoaraType]> {
        return Driver.just(SoaraType.allCases)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
    
    func completeSoaraInput(type: SoaraType) {
        soaraInputSubject.accept(type)
    }
    
    func soaraInputObservable() -> Observable<SoaraType> {
        return soaraInputSubject.asObservable()
    }
    
    // MARK: - Private Method

}
