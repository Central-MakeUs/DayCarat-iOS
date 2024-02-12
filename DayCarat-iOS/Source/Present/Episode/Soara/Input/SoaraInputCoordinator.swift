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
    
    
    func start(title: String, type: SoaraType, id: Int) {
        let vc = SoaraInputViewController(viewModel: SoaraInputViewModel(gemUsecase: JewelryUseCase(repositoy: GemRepository(service: GemService())), id: id, coordinator: self, epiUsecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService()), gemRepository: GemRepository(service: GemService()))), title: title, type: type)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func setAction(_ action: Action) {
        
    }
}
