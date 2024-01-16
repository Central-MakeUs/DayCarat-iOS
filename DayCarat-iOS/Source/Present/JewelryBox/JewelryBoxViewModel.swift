//
//  JewelryBoxViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit

import RxSwift

final class JewelryBoxViewModel:ViewModelType {
    var disposeBag = DisposeBag()
    private let usecase: JewelryUseCaseProtocol
    private let coordinator: JewelryBoxCoordinator?
    
    init(usecase: JewelryUseCaseProtocol, coordinator: JewelryBoxCoordinator?) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
