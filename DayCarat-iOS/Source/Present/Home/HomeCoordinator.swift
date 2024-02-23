//
//  HomeCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    
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
        let vm = HomeViewModel(usecase: HomeUseCase(repository: HomeRepository(serivce: HomeService()), user: UserRepository(service: UserInfoService())), coordinator: self)
        let vc = HomeViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushDetail(idx: Int) {
        let vc = DetailEpiCoordinator(navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.startDetail(id: idx)
    }
    
    func setAction(_ action: Action) {
        
    }
}
