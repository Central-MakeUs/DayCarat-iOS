//
//  EpisodeListCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/14/24.
//

import UIKit

final class EpisodeListCoordinator: Coordinator {
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
    
    func startList(title: String, count: String) {
        let vm = EpisodeListViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService())), coordinator: self, title: title, count: count, gemUsecase: JewelryUseCase(repositoy: GemRepository(service: GemService())))
        let vc = EpisodeListViewController(viewModel: vm)
        vc.hidesBottomBarWhenPushed = true
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
