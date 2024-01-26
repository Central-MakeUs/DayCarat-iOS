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
    
    func startDetail(id: Int) {
        let vm = DetailEpisodeViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService())), coordinator: self, epiId: id)
        let vc = DetailEpisodeViewController(viewModel: vm, id: id)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushSoara() {
        let vc = SoaraCoordinator(navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.startSoara(id: 0)
    }
    
    func start() {

    }

    
    func setAction(_ action: Action) {
        
    }
}
