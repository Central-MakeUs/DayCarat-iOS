//
//  IntroUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import Foundation
import UIKit

import RxSwift

protocol IntroUseCaseProtocol {
    func processIntroCellData() -> IntroCellData
}

final class IntroUseCase: IntroUseCaseProtocol {
    func processIntroCellData() -> IntroCellData {
        return IntroCellData()
    }
}
