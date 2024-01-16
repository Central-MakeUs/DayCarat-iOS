//
//  EpisodeViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit
import RxSwift

final class EpisodeViewModel:ViewModelType {
    var disposeBag = DisposeBag()
    private let usecase: EpisodeUseCase
    let coordinator: EpisodeCoordinator?
    
    init(usecase: EpisodeUseCase, coordinator: EpisodeCoordinator?) {
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
