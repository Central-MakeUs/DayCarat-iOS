//
//  MyPageViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//
import UIKit

import RxSwift
import RxCocoa

final class MyPageViewModel: ViewModelType {

    private let usecase: MyPageUseCaseProtocol
    let coordinator: MyPageCoordinator?
    let userData = PublishSubject<UserDTO>()
    var disposeBag = DisposeBag()
    var appCoordinator: (any Coordinator)?

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
                print(res.result!)
                self?.userData.onNext(res.result!)
            }, onFailure: {  error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func registerImg(img: UIImage) {
        usecase.uploadUserProfileImg(img: img)
            .subscribe(onSuccess: {  res in
                print("업로드 성공=====\(res)")
            })
            .disposed(by: disposeBag)
    }
    
    func deleteUser() {
        usecase.deleteUser()
            .subscribe(onSuccess: { res in
                print("유저삭제=====\(res)")
                self.coordinator?.finish()
                let navigaitonController = UINavigationController()
                self.appCoordinator = AppCoordinator(navigationController: navigaitonController)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                self.appCoordinator = AppCoordinator(navigationController: navigaitonController)
                self.appCoordinator?.start()
                sceneDelegate?.window?.rootViewController = navigaitonController
                sceneDelegate?.window?.makeKeyAndVisible()
            })
            .disposed(by: disposeBag)
    }
}
