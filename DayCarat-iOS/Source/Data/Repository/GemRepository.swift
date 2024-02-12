//
//  GemRepository.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import RxSwift
import RxCocoa

final class GemRepository: JewelryInterface {
    func fetchAiRecommand(episodeId: Int) -> RxSwift.Single<BaseResponse<AiRecommandDTO>> {
        return service.fetchAiRecommand(episodeId: episodeId)
    }
    func registerGem(episodeId: Int) -> RxSwift.Single<BaseResponse<Bool>> {
        return service.registerGem(episodeId: episodeId)
    }
    func fetchSoaraData(episodeId: Int) -> RxSwift.Single<BaseResponse<SoaraInputDTO>> {
        return service.fetchSoaraData(episodeId: episodeId)
    }
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
    
    func patchSoara(episodeId: Int, content1: String? = nil, content2: String? = nil, content3: String? = nil, content4: String? = nil, content5: String? = nil) -> Single<BaseResponse<Bool>> {
        return service.patchSoara(episodeId: episodeId, content1: content1, content2: content2, content3: content3,
        content4: content4, content5: content5)
    }
    
    private let service: GemService
    
    init(service: GemService) {
        self.service = service
    }
}
