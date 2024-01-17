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
    private let epiId : Int
    
    init(usecase: EpisodeUseCaseProtocol, coordinator: DetailEpiCoordinator?, epiId: Int) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.epiId = epiId
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
