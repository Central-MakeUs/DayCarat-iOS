//
//  LoginService.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import Foundation

import Moya
import RxMoya
import RxSwift

class LoginService {
    private let bag = DisposeBag()
    private let provider = MoyaProvider<DayCaratTarget>()

    func requestLogin(accessToken: String) -> Single<BaseResponse<LoginResponse>> {
        return provider.rx
            .request(.login(accessToken: accessToken))
            .filterSuccessfulStatusCodes()
            .map(BaseResponse<LoginResponse>.self)
            .do(onSuccess: { response in
                print(response)
            }, onError: { error in
                if let moyaError = error as? MoyaError,
                   case let .statusCode(response) = moyaError {
                    let data = response.data
                    if let errorMessage = String(data: data, encoding: .utf8) {
                        print("Alamofire Error: \(errorMessage)")
                    }
                } else {
                    print("Moya Error: \(error)")
                }
            })
    }
    
    func requestAppleLogin(id_token: String) -> Single<BaseResponse<LoginResponse>> {
        return Single.create {  single in
            let disposable = self.provider.rx
                .request(.appleLogin(id_token: id_token))
                .filterSuccessfulStatusCodes()
                .map(BaseResponse<LoginResponse>.self)
                .subscribe(onSuccess: { response in
                    single(.success(response))
                }, onFailure: { error in
                    print("애플로그인========\(error)")
                    single(.failure(error))
                })
            return Disposables.create {
                disposable.dispose()
            }
        }

    }
}
