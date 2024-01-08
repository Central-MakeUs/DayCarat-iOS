//
//  IntroViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import Foundation
import UIKit

import RxSwift

final class IntroViewModel: ViewModelType {
    internal var disposeBag = DisposeBag()
    private let introUseCase: IntroUseCaseProtocol

    init(introUseCase: IntroUseCaseProtocol) {
        self.introUseCase = introUseCase
    }

    struct Input {
        
    }

    struct Output {
        let introCellData: Observable<IntroCellData>
    }

    func transform(input: Input) -> Output {
        let introCellDataObservable = Observable.just(introUseCase.processIntroCellData())

        return Output(introCellData: introCellDataObservable)
    }
}
