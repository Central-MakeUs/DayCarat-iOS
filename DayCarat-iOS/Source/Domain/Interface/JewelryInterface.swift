//
//  JewelryInterface.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import RxSwift
import RxCocoa

protocol JewelryInterface {
    func fetchMonthGemCount() -> Single<BaseResponse<GemCountDTO>>
    func fetchTotalGemCount() -> Single<BaseResponse<GemCountDTO>>
    func fetchGemMostKeyword() -> Single<BaseResponse<GemMostKeyword>>
    func fetchGemMostActivityTag() -> Single<BaseResponse<GemMostActivityDTO>>
}
