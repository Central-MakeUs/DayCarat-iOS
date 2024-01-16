//
//  CompleteCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class CompleteCoordinator: Coordinator, CoordinatorDelegate {
    func didFinish(childCoordinator: any Coordinator) {
        
    }
    
    func setAction(_ action: Action) {
        
    }
    
    struct Action {
        
    }
    
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    var delegate: CoordinatorDelegate?
    private var parentCoordinator: (any Coordinator)?
    
    init(parentCoordinator: (any Coordinator)? = nil, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CompleteViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushMain() {
        self.navigationController.isNavigationBarHidden = true
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
    }
}
