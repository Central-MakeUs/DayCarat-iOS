//
//  CreationSoaraViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import RxSwift
import RxCocoa

final class GemViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    private let usecase: EpisodeUseCaseProtocol
    private let gemUsecase: JewelryUseCaseProtocol
    let coordinator: GemCoordinator
    let detailData = PublishRelay<DetailEpisodeDTO>()
    let episodeContents = PublishRelay<[DetailEpisodeContentDTO]>()
    let soaraContents = PublishRelay<[String]>()
    let aiRecommandData = PublishRelay<[String]>()
    let clipboardData = PublishRelay<ClipboardDTO>()

    init(usecase: EpisodeUseCaseProtocol, gemUsecase: JewelryUseCaseProtocol, coordinator: GemCoordinator) {
        self.usecase = usecase
        self.gemUsecase = gemUsecase
        self.coordinator = coordinator
    }
    
    struct Input {
        
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
    
    func updateData(id: Int) {
        usecase.fetchDetailEpi(episodeId: id)
            .subscribe(onSuccess: {  [weak self]  res in
                print(res)
                self?.detailData.accept(res.result!)
                self?.episodeContents.accept(res.result!.episodeContents)
            })
            .disposed(by: disposeBag)
        usecase.getSoaraDetailData(episodeId: id)
            .subscribe(onSuccess: {  [weak self]  res in
                var contents: [String] = []
                if let content1 = res.result?.content1 {
                    contents.append(content1)
                }
                if let content2 = res.result?.content2 {
                    contents.append(content2)
                }
                if let content3 = res.result?.content3 {
                    contents.append(content3)
                }
                if let content4 = res.result?.content4 {
                    contents.append(content4)
                }
                if let content5 = res.result?.content5 {
                    contents.append(content5)
                }
                self?.soaraContents.accept(contents)
            })
            .disposed(by: disposeBag)
        gemUsecase.fetchAiRecommand(episodeId: id)
            .subscribe(onSuccess: {  [weak self]  res in
                var contents: [String] = []
                if let content1 = res.result?.generatedContent1 {
                    contents.append(content1)
                }
                if let content2 = res.result?.generatedContent2 {
                    contents.append(content2)
                }
                if let content3 = res.result?.generatedContent3 {
                    contents.append(content3)
                }
                self?.aiRecommandData.accept(contents)
            })
            .disposed(by: disposeBag)
        gemUsecase.fetchClipboard(episodeId: id)
            .subscribe(onSuccess: {  [weak self]  res in
                self?.clipboardData.accept(res.result!)
            })
            .disposed(by: disposeBag)
    }
}
