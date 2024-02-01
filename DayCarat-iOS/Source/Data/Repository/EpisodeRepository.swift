//
//  EpisodeRepository.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/20/24.
//

import RxSwift

final class EpisodeRepository: EpisodeInterface {

    private let service: EpisodeService
    
    init(service: EpisodeService) {
        self.service = service
    }
    
    func fetchDetailEpi(episodeId: Int) -> RxSwift.Single<BaseResponse<DetailEpisodeDTO>> {
        return service.fetchDetailEpi(episodeId: episodeId)
    }
    
    func registerEpi(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) -> RxSwift.Single<BaseResponse<Bool>> {
        return service.registerEpi(title: title, date: date, activityTag: activityTag, episodeContents: episodeContents)
    }
    
    func fetchActivityEpiList() -> RxSwift.Single<BaseArrayResponse<ActivityEpiQuantityDTO>> {
        return service.fetchActivityEpiList()
    }
    
    func fetchEpiAllCount() -> RxSwift.Single<BaseResponse<epiCount>> {
        return service.fetchEpiAllCount()
    }
}
