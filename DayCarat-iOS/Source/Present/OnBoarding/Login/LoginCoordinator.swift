//
//  LoginCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    enum Action {
        case first
        case notFirst
    }
    
    var delegate: CoordinatorDelegate?
    
    var childCoordinators = [any Coordinator]()

    var navigationController: UINavigationController
    
    init(paraentCoordinator: AppCoordinator?, navigationController: UINavigationController) {
        
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginViewController(viewModel: LoginViewModel(usecase: LoginUseCase(repository: LoginRepository(service: LoginService())), coordinator: self))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushIntro() {
        let introVC = IntroCoordinator(parentCoordinator: self, navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(introVC)
        introVC.start()
    }
    
    func pushMain() {
        self.navigationController.isNavigationBarHidden = true
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
    }
    func setAction(_ action: Action) {
//        switch action {
//        case .first:
//            
//        case .notFirst:
//            
//        }
    }
}
