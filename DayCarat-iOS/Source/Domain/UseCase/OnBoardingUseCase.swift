//
//  OnBoardingUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import Foundation
import RxSwift

protocol OnBoardingUseCaseProtocol {
    func processIntroCellData() -> OnBoardingModel
    func patchUser(nickname: String?, jobTitle: String?, strength: String?, pushAllow: Bool?, fcmToken: String?) ->  Single<BaseResponse<Bool>>
}

final class OnBoardingUseCase: OnBoardingUseCaseProtocol {
    
    private let repository: UserInterface
    
    init(repository: UserInterface) {
        self.repository = repository
    }
    
    func patchUser(nickname: String?, jobTitle: String?, strength: String?, pushAllow: Bool?, fcmToken: String?) -> RxSwift.Single<BaseResponse<Bool>> {
        return repository.patchUser(nickname: nickname, jobTitle: jobTitle, strength: strength, pushAllow: pushAllow, fcmToken: fcmToken)
    }
    
    func processIntroCellData() -> OnBoardingModel {
        return OnBoardingModel()
    }
}
