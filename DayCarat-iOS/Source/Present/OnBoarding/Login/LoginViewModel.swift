//
//  LoginViewModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/09.
//

import RxSwift
import RxCocoa
import KakaoSDKUser
import RxKakaoSDKUser
import RxKakaoSDKAuth
import KakaoSDKAuth

final class LoginViewModel: ViewModelType {
    
    var disposeBag = DisposeBag()
    let kakaoLoginCompleteSubject = PublishSubject<Void>()
    private var isLogin: Bool = false
    private let usecase: LoginUseCaseProtocol
    weak var coordinator: LoginCoordinator?
    private let tokenManager = TokenManager()

    init(usecase: LoginUseCaseProtocol, coordinator: LoginCoordinator? = nil) {
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
    
    func checkLogin() {
        
        if isLogin {
            
        } else {
            
        }
        
    }
    
    func signInWithKakao() {
       UserApi.shared.logout() { _ in }
       if (UserApi.isKakaoTalkLoginAvailable()) {
           UserApi.shared.rx.loginWithKakaoTalk()
               .subscribe(onNext: { [weak self] _ in
                   self?.getKakaUserInfo()
               },
               onError: { error in
                   print("카카오앱에러: \(error)")
               })
           .disposed(by: disposeBag)
       } else {
           UserApi.shared.rx.loginWithKakaoAccount()
               .subscribe(onNext: { [weak self] _ in
                   self?.getKakaUserInfo()
               },
               onError: {  error in
                   print("카카오로그인 웹뷰에러: \(error)")
               })
           .disposed(by: disposeBag)
       }
   }
    
    private func getKakaUserInfo() {
        UserApi.shared.rx.loginWithKakaoAccount(prompts: [.SelectAccount])
            .subscribe(onNext:{ (oauthToken) in
                let token = oauthToken
                self.usecase.login(token: token.accessToken)
                    .subscribe(onSuccess: { [weak self] res in
                        self?.tokenManager.saveToken(res.result!.accessToken)
                        if res.statusCode == 200 {
                            self?.coordinator?.pushMain()
                        }
                        else {
                            self?.kakaoLoginCompleteSubject.onNext(())
                        }
                    },
                    onFailure: {_ in
                        print("LoginVM카톡로그인에러")
                    }
                    )
                    .disposed(by: self.disposeBag)
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
