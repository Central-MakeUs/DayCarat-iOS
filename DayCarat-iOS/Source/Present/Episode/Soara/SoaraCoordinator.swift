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
//        let vm = DetailEpisodeViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService())), coordinator: self, epiId: id)
//        let vc = DetailEpisodeViewController(viewModel: vm)
//        vc.hidesBottomBarWhenPushed = true
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func start() {

    }

    
    func setAction(_ action: Action) {
        
    }
}
