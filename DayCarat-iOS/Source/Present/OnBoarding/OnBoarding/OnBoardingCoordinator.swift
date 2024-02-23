//
//  OnBoardingCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
    
    struct Action {
        
    }
    
    var delegate: CoordinatorDelegate?
    
    var childCoordinators = [any Coordinator]()
    private var parentCoordinator: (any Coordinator)?

    var navigationController: UINavigationController
    
    func setAction(_ action: Action) {
        
    }
    
    init(parentCoordinator: IntroCoordinator ,navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let vc = OnBoardingViewController(viewModel: OnBoardingViewModel(usecase: OnBoardingUseCase(repository: UserRepository(service: UserInfoService())), coordinator: self))
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushComplete() {
        let vc = CompleteCoordinator(parentCoordinator: self, navigationController: navigationController)
        childCoordinators.append(vc)
        vc.start()
    }
}
