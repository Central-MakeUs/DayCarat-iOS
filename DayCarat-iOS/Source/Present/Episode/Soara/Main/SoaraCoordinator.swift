//
//  SoaraCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/22/24.
//

import UIKit

final class SoaraCoordinator: Coordinator {
    
    struct Action {
        
    }
    var childCoordinators: [any Coordinator] = []
    var navigationController: UINavigationController
    var delegate: CoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func startSoara(id: Int) {
        let vc = SoaraViewController(viewModel: SoaraViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService()))), coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushInputSoara(title: String, type: SoaraType) {
        let vc = SoaraInputCoordinator(navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.start(title: title, type: type)
    }
    
    func start() {

    }

    
    func setAction(_ action: Action) {
        
    }
}
