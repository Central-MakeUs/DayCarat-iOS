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
    let info = PublishSubject<OnBoardingModel>()
    init(usecase: OnBoardingUseCaseProtocol) {
        self.usecase = usecase
    }
    
    struct Input {
        let inputText: Observable<String>

    }
    
    struct Output {
        let isNextButtonEnabled: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let isNextButtonEnabled = input.inputText
            .map { $0.count <= 10 } // 최대 10글자까지만 허용
            .startWith(true) // 초기 상태는 활성화로 시작
            .asDriver(onErrorJustReturn: true)
        
        return Output(isNextButtonEnabled: isNextButtonEnabled)
    }
    
    func updateInfo() {
        info.onNext(usecase.processIntroCellData())
    }
}
