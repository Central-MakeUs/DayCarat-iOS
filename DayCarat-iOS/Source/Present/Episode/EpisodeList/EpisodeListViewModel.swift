//
//  EpisodeListViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/10/24.
//

import RxSwift
import RxCocoa

final class EpisodeListViewModel: ViewModelType {
    
    private let usecase: EpisodeUseCaseProtocol
    private let gemUsecase: JewelryUseCaseProtocol
    let coordinator: EpisodeListCoordinator?
    var disposeBag = DisposeBag()
    let headerTitle: String
    let headerCount: String
    let keywordGemList = PublishRelay<[GemKeywordEpi]>()
    let activityEpiList = PublishRelay<[ActivityEpisodeList]>()
    
    init(usecase: EpisodeUseCaseProtocol, coordinator: EpisodeListCoordinator?, title: String, count: String, gemUsecase: JewelryUseCaseProtocol) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.gemUsecase = gemUsecase
        self.headerCount = count
        self.headerTitle = title
        self.updateList(keyword: title)
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    func updateList(keyword: String) {
        
        gemUsecase.fetchKeywordGemList(keyword: keyword)
            .subscribe(onSuccess: {  [weak self]  res in
                self?.keywordGemList.accept(res.result!)
            })
            .disposed(by: disposeBag)
        
        usecase.fetchActivityEpiList(activity: keyword)
            .subscribe(onSuccess: {   [weak  self] res in
                print(res)
                self?.activityEpiList.accept(res.result!)
            })
            .disposed(by: disposeBag)
    }
    
}
