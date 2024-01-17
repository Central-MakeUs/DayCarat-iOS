//
//  HomeInterface.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import RxSwift

protocol HomeInterface {
    func requestMontEpi() -> Single<BaseResponse<epiCount>>
    func fetchRecentEpi() -> Single<BaseArrayResponse<recentEPi>>
}

