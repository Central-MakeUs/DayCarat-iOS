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
    let detailData = PublishRelay<DetailEpisodeDTO>()
    let episodeContents = PublishRelay<[DetailEpisodeContentDTO]>()
    
    init(usecase: EpisodeUseCaseProtocol, coordinator: DetailEpiCoordinator?) {
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
    
    func updateData(id: Int) {
        usecase.fetchDetailEpi(episodeId: id)
            .subscribe(onSuccess: {  [weak self]  res in
                self?.detailData.accept(res.result!)
                self?.episodeContents.accept(res.result!.episodeContents)
            }, onFailure: {  error in
                
            })
            .disposed(by: disposeBag)
    }
}
