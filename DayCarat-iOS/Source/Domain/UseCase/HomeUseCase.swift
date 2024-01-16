//
//  HomeUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/09.
//

import Foundation

import RxSwift

protocol HomeUseCaseeProtocol {
    func homeCellData() -> CellModel
}

final class HomeUseCase: HomeUseCaseeProtocol {
    func homeCellData() -> CellModel {
        return CellModel()
    }
}
