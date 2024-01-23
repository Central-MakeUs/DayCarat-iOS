//
//  EpisodeInputCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import UIKit

final class EpisodeInputCoordinator: Coordinator {
    
    
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
        let vm = EpisodeInputViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService())), coordinator: self)
        let vc = EpisodeInputViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func setAction(_ action: Action) {
        
    }
}
