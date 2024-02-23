//
//  KeywordEditViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/19/24.
//

import RxSwift
import RxCocoa

final class KeywordEditViewModel: ViewModelType {
    private let usecase: EpisodeUseCaseProtocol
    let coordinator: KeywordEditCoordinator?
    var disposeBag = DisposeBag()

    init(usecase: EpisodeUseCaseProtocol, coordinator: KeywordEditCoordinator?) {
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
