//
//  MakeGemViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/9/24.
//

import Foundation

import RxSwift

final class MakeGemViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    private let usecase: JewelryUseCaseProtocol
    let coordinator: MakeGemCoordinator?
    
    init(usecase: JewelryUseCaseProtocol, id: Int, coordinator: MakeGemCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
        self.registerGem(id: id)
    }

    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    func registerGem(id: Int) {
        usecase.registerGem(episodeId: id)
            .subscribe(onSuccess: {  res in
                print("보석등록성공\(res)")
            })
            .disposed(by: disposeBag)
    }
}
