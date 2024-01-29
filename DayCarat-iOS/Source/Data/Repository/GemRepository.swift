//
//  GemRepository.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import RxSwift
import RxCocoa

final class GemRepository: JewelryInterface {
    func fetchKeywordGemList(keyword: String) -> RxSwift.Single<BaseArrayResponse<GemKeywordEpi>> {
        return service.fetchKeywordGemList(keyword: keyword)
    }
    
    func fetchGemKeywordCount() -> RxSwift.Single<BaseResponse<GemKeywordDTO>> {
        return service.fetchGemKeywordCount()
    }
    
    func fetchMonthGemCount() -> RxSwift.Single<BaseResponse<GemCountDTO>> {
        return service.fetchMonthGemCount()
    }
    
    func fetchTotalGemCount() -> RxSwift.Single<BaseResponse<GemCountDTO>> {
        return service.fetchTotalGemCount()
    }
    
    func fetchGemMostKeyword() -> RxSwift.Single<BaseResponse<GemMostKeyword>> {
        return service.fetchGemMostKeyword()
    }
    
    func fetchGemMostActivityTag() -> RxSwift.Single<BaseResponse<GemMostActivityDTO>> {
        return service.fetchGemMostActivityTag()
    }
    
    private let service: GemService
    
    init(service: GemService) {
        self.service = service
    }
}
