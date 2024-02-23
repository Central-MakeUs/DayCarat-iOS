//
//  JewelryBoxCoordinator.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit

final class JewelryBoxCoordinator: Coordinator {
    
    
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
        let vm = JewelryBoxViewModel(usecase: JewelryUseCase(repositoy: GemRepository(service: GemService())), coordinator: self, userInfoUseCase: MyPageUseCase(repository: UserRepository(service: UserInfoService())))
        let vc = JewelryViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushGemKeywordList(keyword: String, count: String, type: EpiListType, keywordtype: KeywordEnum) {
        let vc = EpisodeListCoordinator(navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.startList(title: keyword, count: count, type: type, keywordType: keywordtype)
    }
    
    func pushSoaraCreation(id:Int, type: KeywordEnum) {
        let vc = GemCoordinator(navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.start(id: id, type: type)
    }
    
    func setAction(_ action: Action) {
        
    }
}
