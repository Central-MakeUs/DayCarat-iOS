//
//  HomeViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/09.
//

import RxSwift
import RxCocoa

final class HomeViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    private let usecase : HomeUseCaseeProtocol
    weak var coordinator: HomeCoordinator?
    let monthEpiCount = PublishSubject<Int>()
    let recentEpi = PublishSubject<[recentEPi]>()
    
    init(usecase: HomeUseCaseeProtocol, coordinator: HomeCoordinator) {
        self.usecase = usecase
        self.coordinator = coordinator
    }
    
    struct Input {
        
    }
    
    struct Output {
        let sectionData: Driver<CellModel>
    }
    
    func transform(input: Input) -> Output {
        let helpCellData = Driver.just(usecase.homeCellData())
        return Output(sectionData: helpCellData)
    }
    
    func fetchHomeData() {
        usecase.requestMontEpi()
            .subscribe(onSuccess: {  [weak self] res in
                self?.monthEpiCount.onNext(res.result?.episodeCount ?? 0)
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        usecase.fetchRecentEpi()
            .subscribe(onSuccess: {  [weak self] res in
                self?.recentEpi.onNext(res.result!)
            }, onFailure: { error in
                
            })
            .disposed(by: disposeBag)
    }
    
}
