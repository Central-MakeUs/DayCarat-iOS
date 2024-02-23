//
//  MakeGemCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/9/24.
//

import UIKit

final class MakeGemCoordinator: Coordinator {
    
    func start() {
        
    }
    
    struct Action {
        
    }
    
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    var delegate: CoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    
    func start(id: Int) {
        let vm = MakeGemViewModel(usecase: JewelryUseCase(repositoy: GemRepository(service: GemService())), id: id, coordinator: self)
        let vc = MakeGemViewController(viewModel: vm)
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    
    func goHome() {
        let vc = TabBarCoordinator(navigationController: navigationController)
        vc.tabBarController.hidesBottomBarWhenPushed = true
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.start()
    }
    
    
    func setAction(_ action: Action) {
        
    }
}
