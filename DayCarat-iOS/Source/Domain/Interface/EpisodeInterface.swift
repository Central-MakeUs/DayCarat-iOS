//
//  EpisodeInterface.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import RxSwift

protocol EpisodeInterface {
    func registerEpi(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) -> Single<BaseResponse<Bool>>
    func fetchDetailEpi(episodeId: Int) -> Single<BaseResponse<DetailEpisodeDTO>>
    func fetchActivityEpiList() -> Single<BaseArrayResponse<ActivityEpiQuantityDTO>>
    func fetchEpiAllCount() -> Single<BaseResponse<epiCount>>
    func fetchActivityEpiList(activity: String) -> Single<BaseArrayResponse<ActivityEpisodeList>>
}
