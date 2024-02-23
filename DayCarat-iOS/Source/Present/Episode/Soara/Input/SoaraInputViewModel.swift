//
//  SoaraInputViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/8/24.
//

import Foundation

import RxSwift

final class SoaraInputViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    private let gemUsecase: JewelryUseCaseProtocol
    private let epiUsecase: EpisodeUseCaseProtocol
    private let id: Int
    let coordinator: SoaraInputCoordinator?
    
    
    init(gemUsecase: JewelryUseCaseProtocol, id: Int, coordinator: SoaraInputCoordinator, epiUsecase: EpisodeUseCaseProtocol) {
        self.gemUsecase = gemUsecase
        self.id = id
        self.coordinator = coordinator
        self.epiUsecase = epiUsecase
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    func inputSoara(type: SoaraType, content1: String?, content2: String?, content3: String?, content4: String?, content5: String?) {
        gemUsecase.patchSoara(episodeId: id, content1: content1, content2: content2, content3: content3,
                              content4: content4, content5: content5)
        .subscribe(onSuccess: {  [weak self] res in
            self?.epiUsecase.completeSoaraInput(type: type)
            self?.coordinator?.popupViewController()
            
        })
        .disposed(by: disposeBag)
    }
}
