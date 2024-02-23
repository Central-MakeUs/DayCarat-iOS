//
//  KeywordEditCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/19/24.
//

import UIKit

final class KeywordEditCoordinator: Coordinator {
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
        let vm = KeywordEditViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService()), gemRepository: GemRepository(service: GemService())), coordinator: self)
        let vc = KeywordEditViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func setAction(_ action: Action) {
        
    }
}
