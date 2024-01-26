//
//  JewelryBoxViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit

import RxSwift
import RxCocoa

final class JewelryBoxViewModel:ViewModelType {
    var disposeBag = DisposeBag()
    private let usecase: JewelryUseCaseProtocol
    let coordinator: JewelryBoxCoordinator?

    
    let headerData = PublishRelay<(total: GemCountDTO, month: GemCountDTO, mostKeyword: GemMostKeyword, mostActivity: GemMostActivityDTO)>()

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
    
    func upadetGemData() {
        
        let totalGemObservable = usecase.fetchTotalGemCount().map { $0.result! }.asObservable()
        let monthGemObservable = usecase.fetchMonthGemCount().map { $0.result! }.asObservable()
        let mostKeywordObservable = usecase.fetchGemMostKeyword().map { $0.result! }.asObservable()
        let mostTagObservable = usecase.fetchGemMostActivityTag().map { $0.result! }.asObservable()

        Observable.combineLatest(totalGemObservable, monthGemObservable, mostKeywordObservable, mostTagObservable)
            .subscribe(onNext: { [weak self] (totalGem, monthGem, keyword, tag) in
                self?.headerData.accept((total: totalGem, month: monthGem, mostKeyword: keyword, mostActivity: tag ))
            }, onError: { error in
                print("쥬얼리뷰모델",error)
            })
            .disposed(by: disposeBag)
    }
}
