//
//  EpisodeViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit

import RxSwift
import RxCocoa

final class EpisodeViewModel:ViewModelType {
    var disposeBag = DisposeBag()
    private let usecase: EpisodeUseCase
    let coordinator: EpisodeCoordinator?
    let allCount = PublishRelay<epiCount>()
    let activityEpi = PublishRelay<[ActivityEpiQuantityDTO]>()

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
    
    func updateData() {
        usecase.fetchEpiAllCount()
            .subscribe(onSuccess: {  [weak self]  res in
                self?.allCount.accept(res.result!)
            })
            .disposed(by: disposeBag)
        usecase.fetchActivityEpiList()
            .subscribe(onSuccess: {  [weak self]  res in
                self?.activityEpi.accept(res.result!)
            })
            .disposed(by: disposeBag)
    }
}
