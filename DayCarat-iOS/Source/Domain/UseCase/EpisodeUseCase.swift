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
}
final class EpisodeUseCase: EpisodeUseCaseProtocol {

    private let epiRepository: EpisodeRepository
    
    init(epiRepository: EpisodeRepository) {
        self.epiRepository = epiRepository
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
    //MARK: - Metod to Model
    
    func getSoara() -> Driver<[SoaraType]> {
        return Driver.just(SoaraType.allCases)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}
