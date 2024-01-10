//
//  LoginCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController
    
    init(paraentCoordinator: AppCoordinator?, navigationController: UINavigationController) {
        
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushIntro() {
        let introVC = IntroCoordinator(parentCoordinator: self, navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(introVC)
        introVC.start()
    }
}
