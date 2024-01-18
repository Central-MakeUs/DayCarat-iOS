//
//  HomeUseCase.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/09.
//

import Foundation

import RxSwift

protocol HomeUseCaseeProtocol {
    func requestMontEpi() -> Single<BaseResponse<epiCount>>
    func homeCellData() -> CellModel
    func fetchRecentEpi() -> Single<BaseArrayResponse<recentEPi>>
    func fetchUserInfo() -> Single<BaseResponse<UserDTO>>
}

final class HomeUseCase: HomeUseCaseeProtocol {
    
    private let repository: HomeInterface
    private let userRepository: UserInterface
    
    init(repository: HomeInterface, user: UserInterface) {
        self.repository = repository
        self.userRepository = user
    }
    
    func fetchUserInfo() -> RxSwift.Single<BaseResponse<UserDTO>> {
        return userRepository.fetchUserInfo()
    }
    
    func requestMontEpi() -> RxSwift.Single<BaseResponse<epiCount>> {
        return repository.requestMontEpi()
    }
    
    func homeCellData() -> CellModel {
        return CellModel()
    }
    
    func fetchRecentEpi() -> RxSwift.Single<BaseArrayResponse<recentEPi>> {
        return repository.fetchRecentEpi()
    }
}
