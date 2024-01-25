//
//  SoaraViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/22/24.
//

import RxSwift
import RxCocoa

final class SoaraViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    private let usecase: EpisodeUseCaseProtocol
    let inputData = BehaviorRelay<(String, SoaraType)?>(value: nil)

    init(usecase: EpisodeUseCaseProtocol) {
        self.usecase = usecase
    }
    
    struct Input {
        
    }
    
    struct Output {
        let soaraData: Driver<[SoaraType]>
    }
    
    func transform(input: Input) -> Output {
        let soaraData = usecase.getSoara()
        return Output(soaraData: soaraData)
    }
}
