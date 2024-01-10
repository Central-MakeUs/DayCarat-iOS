//
//  OnBoardingCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var parentCoordinator: Coordinator?

    var navigationController: UINavigationController
    
    init(parentCoordinator: IntroCoordinator ,navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let vc = OnBoardingViewController(viewModel: OnBoardingViewModel(usecase: OnBoardingUseCase()))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func pushComplete() {
        let vc = CompleteCoordinator(parentCoordinator: self, navigationController: navigationController)
        childCoordinators.append(vc)
        vc.start()
    }
}
