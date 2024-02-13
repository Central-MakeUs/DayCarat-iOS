//
//  JewelryUseCase.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import RxSwift
import RxCocoa

protocol JewelryUseCaseProtocol {
    func fetchMonthGemCount() -> Single<BaseResponse<GemCountDTO>>
    func fetchTotalGemCount() -> Single<BaseResponse<GemCountDTO>>
    func fetchGemMostKeyword() -> Single<BaseResponse<GemMostKeyword>>
    func fetchGemMostActivityTag() -> Single<BaseResponse<GemMostActivityDTO>>
    func fetchKeywordGemList(keyword: String) -> Single<BaseArrayResponse<GemKeywordEpi>>
    func fetchGemKeywordCount() -> Single<[GemKeywordInfo]>
    func getGemKeywordData() -> Driver<[KeywordEnum]>
    func patchSoara(episodeId: Int, content1: String?, content2: String?, content3: String?, content4: String?, content5: String?) -> Single<BaseResponse<Bool>>
    func registerGem(episodeId: Int) -> Single<BaseResponse<Bool>>
    func fetchAiRecommand(episodeId: Int) -> Single<BaseResponse<AiRecommandDTO>>
    func fetchClipboard(episodeId: Int) -> Single<BaseResponse<ClipboardDTO>>
}
final class JewelryUseCase: JewelryUseCaseProtocol {
    
    //MARK: - Properties
    
    private let repositoy: JewelryInterface
    //MARK: - Init

    init(repositoy: JewelryInterface) {
        self.repositoy = repositoy
    }
    //MARK: - Method to Network
    
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
    
    func fetchGemKeywordCount() -> Single<[GemKeywordInfo]> {
        return repositoy.fetchGemKeywordCount().map { response in
            return KeywordEnum.allCases.map { keyword in
                let count: Int
                switch keyword {
                case .communication:
                    count = response.result!.communication
                case .problemSolving:
                    count = response.result!.problemSolving
                case .creativity:
                    count = response.result!.creativity
                case .challengeSpirit:
                    count = response.result!.challengeSpirit
                case .proficiency:
                    count = response.result!.proficiency
                case .execution:
                    count = response.result!.execution
                case .unset:
                    count = response.result!.unset
                }
                return GemKeywordInfo(keyword: keyword, count: count, title: keyword.gemTitle, image: keyword.gemImg)
            }
        }
    }
    
    func fetchKeywordGemList(keyword: String) -> RxSwift.Single<BaseArrayResponse<GemKeywordEpi>> {
        return repositoy.fetchKeywordGemList(keyword: keyword)
    }
    
    func patchSoara(episodeId: Int, content1: String?, content2: String?, content3: String?, content4: String?, content5: String?) -> RxSwift.Single<BaseResponse<Bool>> {
        return repositoy.patchSoara(episodeId: episodeId, content1: content1, content2: content2, content3: content3,
                                    content4: content4, content5: content5)
    }
    
    func registerGem(episodeId: Int) -> RxSwift.Single<BaseResponse<Bool>> {
        return repositoy.registerGem(episodeId: episodeId)
    }
    
    func fetchAiRecommand(episodeId: Int) -> RxSwift.Single<BaseResponse<AiRecommandDTO>> {
        return repositoy.fetchAiRecommand(episodeId: episodeId)
    }
    
    func fetchClipboard(episodeId: Int) -> RxSwift.Single<BaseResponse<ClipboardDTO>> {
        return repositoy.fetchClipboard(episodeId: episodeId)
    }
    
    //MARK: - Method to Model
    func getGemKeywordData() -> RxCocoa.Driver<[KeywordEnum]> {
        return Driver.just(KeywordEnum.allCases)
    }
}
