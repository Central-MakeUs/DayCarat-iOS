//
//  EpisodeListCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import UIKit

final class EpisodeListCoordinator: Coordinator {
    
    
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
        let vm = EpisodeListViewModel(usecase: EpisodeUseCase(), coordinator: self)
        let vc = EpisodeListViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
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
