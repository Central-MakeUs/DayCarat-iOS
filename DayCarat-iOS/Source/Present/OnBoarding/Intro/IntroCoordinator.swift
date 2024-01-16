//
//  IntroCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class IntroCoordinator: Coordinator {

    struct Action {
        
    }
    
    var delegate: CoordinatorDelegate?
    
    private var parentCoordinator: (any Coordinator)?
    var navigationController: UINavigationController
    var childCoordinators = [any Coordinator]()

    init(parentCoordinator: LoginCoordinator?, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = IntroViewController(viewModel: IntroViewModel(introUseCase: IntroUseCase()))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func setAction(_ action: Action) {
        
    }
    
    func pushOnBoarding() {
        let vc = OnBoardingCoordinator(parentCoordinator: self, navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.start()
    }
}
