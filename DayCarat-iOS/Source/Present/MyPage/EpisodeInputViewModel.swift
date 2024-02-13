//
//  EpisodeInputViewModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import RxSwift
import RxCocoa

final class EpisodeInputViewModel: ViewModelType {

    private let usecase: EpisodeUseCase
    let coordinator: EpisodeInputCoordinator?
    var disposeBag = DisposeBag()
    var episodeContents = PublishRelay<[EpisodeInputContent]>()

    init(usecase: EpisodeUseCase, coordinator: EpisodeInputCoordinator?) {
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
    
    func registerEpi(title: String, date: String, activityTag: String, episodeContents: [EpisodeInputContent]) {
        
        usecase.registerEpi(title: title, date: date, activityTag: activityTag, episodeContents: episodeContents)
            .subscribe(onSuccess: {  [weak self]_ in
                self?.coordinator?.popupViewController()
            })
            .disposed(by: disposeBag)
    }
    func addEpisodeContent(_ newContent: EpisodeInputContent) {
        episodeContents
            .take(1)
            .subscribe(onNext: { [weak self] currentContents in
                var updatedContents = currentContents
                updatedContents.append(newContent)
                self?.episodeContents.accept(updatedContents)
                print("asasd")
            })
            .disposed(by: disposeBag)
    }
}
