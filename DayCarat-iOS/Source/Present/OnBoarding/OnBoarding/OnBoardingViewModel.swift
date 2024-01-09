//
//  OnBoardingViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import Foundation

import RxSwift
import RxCocoa

final class OnBoardingViewModel:ViewModelType {
    
    var disposeBag = DisposeBag()
    
    private let usecase: OnBoardingUseCaseProtocol
    init(usecase: OnBoardingUseCaseProtocol) {
        self.usecase = usecase
    }
    
    struct Input {
    }
    
    struct Output {
        let sectionData: Driver<OnBoardingModel>
    }
    
    func transform(input: Input) -> Output {
        let jobSectionData = Driver.just(usecase.processIntroCellData())
        
        return Output(sectionData: jobSectionData)
    }
}
