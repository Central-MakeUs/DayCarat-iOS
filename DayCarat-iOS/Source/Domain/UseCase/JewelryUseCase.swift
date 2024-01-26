//
//  JewelryUseCase.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import RxSwift

protocol JewelryUseCaseProtocol {
    func fetchMonthGemCount() -> Single<BaseResponse<GemCountDTO>>
    func fetchTotalGemCount() -> Single<BaseResponse<GemCountDTO>>
    func fetchGemMostKeyword() -> Single<BaseResponse<GemMostKeyword>>
    func fetchGemMostActivityTag() -> Single<BaseResponse<GemMostActivityDTO>>
}
final class JewelryUseCase: JewelryUseCaseProtocol {
    
    private let repositoy: JewelryInterface
    
    init(repositoy: JewelryInterface) {
        self.repositoy = repositoy
    }
    
    func fetchMonthGemCount() -> RxSwift.Single<BaseResponse<GemCountDTO>> {
        return repositoy.fetchMonthGemCount()
    }
    
    func fetchTotalGemCount() -> RxSwift.Single<BaseResponse<GemCountDTO>> {
        return repositoy.fetchTotalGemCount()
    }
    
    func fetchGemMostKeyword() -> RxSwift.Single<BaseResponse<GemMostKeyword>> {
        return repositoy.fetchGemMostKeyword()
    }
    
    func fetchGemMostActivityTag() -> RxSwift.Single<BaseResponse<GemMostActivityDTO>> {
        return repositoy.fetchGemMostActivityTag()
    }
}
