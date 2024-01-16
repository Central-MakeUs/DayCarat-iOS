//
//  DetailEpiCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import UIKit

final class DetailEpiCoordinator: Coordinator {
    
    
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
        let vm = DetailEpisodeViewModel(usecase: EpisodeUseCase(), coordinator: self)
        let vc = DetailEpisodeViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func setAction(_ action: Action) {
        
    }
}
