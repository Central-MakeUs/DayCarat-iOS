//
//  AppCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    func start() {
        let loginCoordinator = LoginCoordinator(paraentCoordinator: self, navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
