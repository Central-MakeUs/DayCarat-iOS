//
//  TabBarCoordinator.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    
    struct Action {
        
    }
    
    var delegate: CoordinatorDelegate?
    lazy var tabBarController: CustomTabBarController = {
        let tabBar = CustomTabBarController(coordinator: self)
        return tabBar
    }()
    var childCoordinators = [any Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func setAction(_ action: Action) {
        
    }
    
    func start() {
        let items: [UINavigationController] = TabBarItem.allCases.map {
            createNavigationController(item: $0)
        }
        configureTabBarController(with: items)
    }
    
    func pushInput() {
        let epiInputCoordinator = EpisodeInputCoordinator(navigationController: navigationController)
        epiInputCoordinator.delegate = self
        epiInputCoordinator.start()
        childCoordinators.append(epiInputCoordinator)
    }
}
private extension TabBarCoordinator {
    private func configureTabBarController(with tabViewControllers: [UIViewController]) {
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.tabBarController.setViewControllers(tabViewControllers, animated: false)
        self.navigationController.viewControllers = [tabBarController]
    }
    
    func createNavigationController(item: TabBarItem) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.tabBarItem = item.item
        configureTabBarCoordinator(item: item, navigationController: navigationController)
        return navigationController
    }
    
    func configureTabBarCoordinator(item: TabBarItem, navigationController nc: UINavigationController) {
        switch item {
            
        case .home:
            let homeCoodinator = HomeCoordinator(navigationController: nc)
            homeCoodinator.delegate = self
            homeCoodinator.start()
            childCoordinators.append(homeCoodinator)
        case .episode:
            let episodeCoordinator = EpisodeCoordinator(navigationController: nc)
            episodeCoordinator.delegate = self
            episodeCoordinator.start()
            childCoordinators.append(episodeCoordinator)
        case .epiInput:
            break
        case .jewerlyBox:
            let jewerlyBoxCoordinator = JewelryBoxCoordinator(navigationController: nc)
            jewerlyBoxCoordinator.delegate = self
            jewerlyBoxCoordinator.start()
            childCoordinators.append(jewerlyBoxCoordinator)
        case .mypage:
            let myPageCoordinator = MyPageCoordinator(navigationController: nc)
            myPageCoordinator.delegate = self
            myPageCoordinator.start()
            childCoordinators.append(myPageCoordinator)
        }
    }
}

extension TabBarCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: any Coordinator) {
        finish()
        childCoordinators = []
    }
}
