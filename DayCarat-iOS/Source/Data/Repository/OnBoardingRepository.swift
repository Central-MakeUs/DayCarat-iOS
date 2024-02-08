//
//  OnBoardingRepository.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import Foundation

import RxSwift
import RxCocoa

final class OnBoardingRepository: OnBoardingInterface {
    private let service: LoginService
    
    init(service: LoginService) {
        self.service = service
    }
    
}
