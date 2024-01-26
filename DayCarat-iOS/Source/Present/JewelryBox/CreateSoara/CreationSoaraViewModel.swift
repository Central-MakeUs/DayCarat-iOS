//
//  CreationSoaraViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import RxSwift
import RxCocoa

final class CreationSoaraViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    private let usecase: EpisodeUseCaseProtocol

    init(usecase: EpisodeUseCaseProtocol) {
        self.usecase = usecase
    }
    
    struct Input {
        
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
