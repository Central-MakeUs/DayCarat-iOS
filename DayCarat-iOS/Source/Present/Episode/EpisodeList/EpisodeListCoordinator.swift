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
    
    func startList(title: String, count: String, type: EpiListType, keywordType: KeywordEnum) {
        let vm = EpisodeListViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService()), gemRepository: GemRepository(service: GemService())), coordinator: self, title: title, count: count, gemUsecase: JewelryUseCase(repositoy: GemRepository(service: GemService())))
        let vc = EpisodeListViewController(viewModel: vm, type: type, kewordtype: keywordType)
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushDetail(idx: Int) {
        let vc = DetailEpiCoordinator(navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.startDetail(id: idx)
    }
    
    func pushGemDetail(id: Int, type: KeywordEnum) {
        let vc = GemCoordinator(navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.start(id: id, type: type)
    }
    
    func setAction(_ action: Action) {
        
    }
}
