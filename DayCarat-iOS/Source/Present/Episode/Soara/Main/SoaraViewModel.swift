//
//  SoaraViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/22/24.
//

import RxSwift
import RxCocoa

final class SoaraViewModel: ViewModelType {

    var disposeBag = DisposeBag()
    private let usecase: EpisodeUseCaseProtocol
    let inputData = BehaviorRelay<(String, SoaraType)?>(value: nil)
    let epiData = PublishRelay<DetailEpisodeDTO>()
    let episodeContents = PublishRelay<[DetailEpisodeContentDTO]>()
    let selectedSoara = PublishRelay<[SoaraType]>()
    
    init(usecase: EpisodeUseCaseProtocol) {
        self.usecase = usecase
    }
    
    struct Input {
        
    }
    
    struct Output {
        let soaraData: Driver<[SoaraType]>
    }
    
    func transform(input: Input) -> Output {
        let soaraData = usecase.getSoara()
        return Output(soaraData: soaraData)
    }
    
    func updateDate(id: Int) {
        usecase.fetchDetailEpi(episodeId: id)
            .subscribe(onSuccess: {  [weak self]  res in
                self?.epiData.accept(res.result!)
                self?.episodeContents.accept(res.result!.episodeContents)
            })
            .disposed(by: disposeBag)
        
        usecase.fetchSoaraData(episodeId: id)
            .subscribe(onSuccess:  {  [weak self]  res in
                print(res.count)
                self?.selectedSoara.accept(res)
            })
            .disposed(by: disposeBag)
    }
}
