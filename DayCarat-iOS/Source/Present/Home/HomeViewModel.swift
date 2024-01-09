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
        let sectionData: Driver<CellModel>
    }
    
    func transform(input: Input) -> Output {
        let helpCellData = Driver.just(usecase.homeCellData())
        return Output(sectionData: helpCellData)
    }
    
}
