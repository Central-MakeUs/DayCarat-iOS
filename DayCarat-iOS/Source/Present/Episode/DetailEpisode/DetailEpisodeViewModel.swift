//
//  DetailEpisodeViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/12.
//
import UIKit

import RxSwift
import RxCocoa

final class DetailEpisodeViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    private let usecase: EpisodeUseCaseProtocol
    let coordinator: DetailEpiCoordinator?
    
    
    init(usecase: EpisodeUseCaseProtocol, coordinator: DetailEpiCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    struct Input {
        
    }
    
    struct Output {
        let dummy: Driver<DetailEpiModel>
    }
    
    func transform(input: Input) -> Output {
        let data = Driver.just(usecase.getDummy())
        return Output(dummy: data)
    }
}
