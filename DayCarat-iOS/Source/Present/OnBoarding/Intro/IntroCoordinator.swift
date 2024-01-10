//
//  IntroCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class IntroCoordinator: Coordinator {
    private var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()

    init(parentCoordinator: LoginCoordinator?, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = IntroViewController(viewModel: IntroViewModel(introUseCase: IntroUseCase()))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushOnBoarding() {
        let vc = OnBoardingCoordinator(parentCoordinator: self, navigationController: navigationController)
        navigationController.isNavigationBarHidden = true
        childCoordinators.append(vc)
        vc.start()
    }
    
    func popVC() {
        parentCoordinator?.removeChildCoordinator(child: self)
    }
}
