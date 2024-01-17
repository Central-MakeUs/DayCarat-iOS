//
//  HomeRepository.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import RxSwift

final class HomeRepository: HomeInterface {
    
    let serivce: HomeService
    
    init(serivce: HomeService) {
        self.serivce = serivce
    }
    
    func requestMontEpi() -> RxSwift.Single<BaseResponse<epiCount>> {
        return serivce.requestMontEpi()
    }
    
    func fetchRecentEpi() -> RxSwift.Single<BaseArrayResponse<recentEPi>> {
        return serivce.fetchRecentEpi()
    }
}
