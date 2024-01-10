//
//  CompleteCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class CompleteCoordinator: Coordinator {
    var childCoordinators =  [Coordinator]()
    private var parentCoordinator: Coordinator?

    var navigationController: UINavigationController
    
    init(parentCoordinator: Coordinator? = nil, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CompleteViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushMain() {
        let vc = CustomTabBarController()
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
    
    func popVC() {
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
