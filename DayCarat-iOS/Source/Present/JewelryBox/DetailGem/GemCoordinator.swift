//
//  CreationSoaraCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import UIKit

final class GemCoordinator: Coordinator {
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
    
    func start(id: Int, type: KeywordEnum) {
        let vm = GemViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService()), gemRepository: GemRepository(service: GemService())), gemUsecase: JewelryUseCase(repositoy: GemRepository(service: GemService())), coordinator: self)
        let vc = GemViewController(viewModel: vm, id: id, type: type)
        navigationController.pushViewController(vc, animated: true)
    }

    
    func setAction(_ action: Action) {
        
    }
}
