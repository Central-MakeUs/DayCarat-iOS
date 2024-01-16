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
    let coordinator: EpisodeListCoordinator?
    var disposeBag = DisposeBag()
    
    init(usecase: EpisodeUseCaseProtocol, coordinator: EpisodeListCoordinator?) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
