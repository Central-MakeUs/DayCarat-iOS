//
//  JewelryInterface.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import RxSwift
import RxCocoa

protocol JewelryInterface {
    func patchSoara(episodeId: Int, content1: String?, content2: String?, content3: String?, content4: String?, content5: String?) -> Single<BaseResponse<Bool>>
    func fetchMonthGemCount() -> Single<BaseResponse<GemCountDTO>>
    func fetchTotalGemCount() -> Single<BaseResponse<GemCountDTO>>
    func fetchGemMostKeyword() -> Single<BaseResponse<GemMostKeyword>>
    func fetchGemMostActivityTag() -> Single<BaseResponse<GemMostActivityDTO>>
    func fetchKeywordGemList(keyword: String) -> Single<BaseArrayResponse<GemKeywordEpi>>
    func fetchGemKeywordCount() -> Single<BaseResponse<GemKeywordDTO>>
    func fetchSoaraData(episodeId: Int) -> Single<BaseResponse<SoaraInputDTO>>
    func registerGem(episodeId: Int) -> Single<BaseResponse<Bool>>
    func fetchAiRecommand(episodeId: Int) -> Single<BaseResponse<AiRecommandDTO>>
}
