//
//  JewelryBoxCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit

final class JewelryBoxCoordinator: Coordinator {
    
    
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
        let vm = JewelryBoxViewModel(usecase: JewelryUseCase(), coordinator: self)
        let vc = JewelryViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func setAction(_ action: Action) {
        
    }
}
