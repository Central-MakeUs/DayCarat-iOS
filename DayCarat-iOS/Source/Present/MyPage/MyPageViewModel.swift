//
//  MyPageViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import RxSwift
import RxCocoa

final class MyPageViewModel: ViewModelType {

    private let usecase: MyPageUseCaseProtocol
    private let coordinator: MyPageCoordinator?
    let userData = PublishSubject<UserDTO>()
    var disposeBag = DisposeBag()
    
    init(usecase: MyPageUseCaseProtocol, coordinator: MyPageCoordinator?) {
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
    
    func fetchInfo() {
        usecase.fetchUserInfo()
            .subscribe(onSuccess: {  [weak self]  res in
                self?.userData.onNext(res.result!)
            }, onFailure: {  error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
