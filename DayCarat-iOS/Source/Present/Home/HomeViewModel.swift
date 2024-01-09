//
//  HomeViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/09.
//

import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    private let usecase : HomeUseCaseeProtocol
    
    init(usecase: HomeUseCaseeProtocol) {
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
