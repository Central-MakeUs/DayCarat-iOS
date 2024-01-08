//
//  Coordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
