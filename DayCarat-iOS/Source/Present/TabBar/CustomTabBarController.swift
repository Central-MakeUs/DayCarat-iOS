//
//  CustomTabBarController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

import Then
import SnapKit

final class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    weak var coordinator: TabBarCoordinator?

    private let middleBtn = UIButton().then {
        $0.setImage(UIImage(named: "input"), for: .normal)
    }
    
    init(coordinator: TabBarCoordinator? = nil) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setMiddleBtn()
        configure()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            if viewController.tabBarItem.tag == TabBarItem.epiInput.item.tag {
                coordinator?.pushInput()
                return false
            }
            return true
        }
    
    private func configure() {
        self.tabBar.tintColor = .Main
        self.tabBar.backgroundColor = .Gray50
    }
    
    private func setMiddleBtn() {
        self.tabBar.addSubview(middleBtn)

        middleBtn.isUserInteractionEnabled = true
        self.tabBar.bringSubviewToFront(middleBtn)
        middleBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.height.equalTo(56)
        }
    }
}
