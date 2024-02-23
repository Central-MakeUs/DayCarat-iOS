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
    weak var coordinator: OnBoardingCoordinator?

    private let usecase: OnBoardingUseCaseProtocol
    init(usecase: OnBoardingUseCaseProtocol, coordinator: OnBoardingCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
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
    
    func inputData(nickname: String, jobTitle: String, strength: String, fcmToken: String? = nil) {
        usecase.patchUser(nickname: nickname, jobTitle: jobTitle, strength: strength, pushAllow: true, fcmToken: fcmToken)
            .subscribe(onSuccess: {  [weak self] res in
                print("=========성공!\(res)")
                self?.coordinator?.pushComplete()
            })
            .disposed(by: disposeBag)
    }
}
