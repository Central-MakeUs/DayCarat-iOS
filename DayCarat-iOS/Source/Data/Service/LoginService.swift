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
}
