//
//  OnBoardingUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import Foundation

protocol OnBoardingUseCaseProtocol {
    func processIntroCellData() -> OnBoardingModel
}

final class OnBoardingUseCase: OnBoardingUseCaseProtocol {
    func processIntroCellData() -> OnBoardingModel {
        return OnBoardingModel()
    }
}
