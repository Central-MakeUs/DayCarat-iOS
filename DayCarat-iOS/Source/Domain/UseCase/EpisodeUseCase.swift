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
    func getDummy() -> DetailEpiModel
    func registerEpi(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) -> Single<BaseResponse<Bool>>
    func fetchDetailEpi(episodeId: Int) -> RxSwift.Single<BaseResponse<DetailEpisodeDTO>>
}
final class EpisodeUseCase: EpisodeUseCaseProtocol {
    

    private let epiRepository: EpisodeRepository
    
    init(epiRepository: EpisodeRepository) {
        self.epiRepository = epiRepository
    }
    
    func registerEpi(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) -> RxSwift.Single<BaseResponse<Bool>> {
        return epiRepository.registerEpi(title: title, date: date, activityTag: activityTag, episodeContents: episodeContents)
    }
    
    func fetchDetailEpi(episodeId: Int) -> RxSwift.Single<BaseResponse<DetailEpisodeDTO>> {
        return epiRepository.fetchDetailEpi(episodeId: episodeId)
    }
    
    func getDummy() -> DetailEpiModel {
        return DetailEpiModel()
    }
    
    func getSoara() -> Driver<[SoaraType]> {
        return Driver.just(SoaraType.allCases)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}
