//
//  SoaraInputCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/24.
//

import UIKit

final class SoaraInputCoordinator: Coordinator {
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
    
    
    func start(title: String, type: SoaraType) {
        let vc = SoaraInputViewController(viewModel: SoaraViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService()))), title: title, type: type)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func setAction(_ action: Action) {
        
    }
}
