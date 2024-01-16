//
//  EpisodeUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/12.
//

import RxSwift
import RxCocoa

protocol EpisodeUseCaseProtocol {
    func getDummy() -> DetailEpiModel
}
final class EpisodeUseCase: EpisodeUseCaseProtocol {
    func getDummy() -> DetailEpiModel {
        return DetailEpiModel()
    }
}
