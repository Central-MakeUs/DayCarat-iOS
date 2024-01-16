//
//  EpisodeInputViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import RxSwift
import RxCocoa

final class EpisodeInputViewModel: ViewModelType {

    private let usecase: EpisodeUseCase
    let coordinator: EpisodeInputCoordinator?
    var disposeBag = DisposeBag()
    
    init(usecase: EpisodeUseCase, coordinator: EpisodeInputCoordinator?) {
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
