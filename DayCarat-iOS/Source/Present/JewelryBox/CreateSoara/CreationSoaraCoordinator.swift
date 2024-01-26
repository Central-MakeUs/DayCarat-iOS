//
//  CreationSoaraCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import UIKit

final class CreationSoaraCoordinator: Coordinator {
    struct Action {
        
    }
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    var delegate: CoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        let vc = CreateSoaraViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    
    func setAction(_ action: Action) {
        
    }

}
