//
//  CustomTabBarController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxCocoa

final class CustomTabBarController: UITabBarController {
    
    private let middleBtn = UIButton().then {
        $0.setImage(UIImage(named: "input"), for: .normal)
    }
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
        setMiddleBtn()
        setTabBarItems()
        binding()
    }
    
    private func configureTabBarAppearance() {
        let tabBarBackgroundImage = UIImage.imageWithColor(color: UIColor.white.withAlphaComponent(0.8))
        tabBar.backgroundImage = tabBarBackgroundImage
        tabBar.shadowImage = UIImage()
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(blurView, at: 0)
    }
    
    private func setMiddleBtn() {
        self.tabBar.addSubview(middleBtn)
        middleBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.height.equalTo(56)
        }
    }
    
    private func setTabBarItems() {
        let homeVC = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel(usecase: HomeUseCase())))
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "basehome"), tag: 0)
        homeVC.navigationBar.isHidden = true
        
        let folderVC = UINavigationController(rootViewController: EpisodeViewController())
        folderVC.tabBarItem = UITabBarItem(title: "에피소드", image: UIImage(named: "basefolder"), tag: 1)
        folderVC.navigationBar.isHidden = true
        
        let episodeInputVC = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel(usecase: HomeUseCase())))
        episodeInputVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus"), tag: 2)
        episodeInputVC.navigationBar.isHidden = true
        episodeInputVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.main], for: .normal)
        episodeInputVC.tabBarItem.isEnabled = false

        let jewelryBoxVC = UINavigationController(rootViewController: JewelryViewController())
        jewelryBoxVC.tabBarItem = UITabBarItem(title: "보석함", image: UIImage(named: "basejewelry"), tag: 3)
        jewelryBoxVC.navigationBar.isHidden = true
        
        let myPageVC = UINavigationController(rootViewController: MyPageViewController())
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "baseuser"), tag: 4)
        myPageVC.navigationBar.isHidden = true
        
        self.tabBar.tintColor = .main
        
        setViewControllers([homeVC, folderVC, episodeInputVC, jewelryBoxVC, myPageVC], animated: false)

    }
    
    private func binding() {
        middleBtn.rx.tap
            .asDriver()
            .drive(onNext: {
                
            })
            .disposed(by: disposeBag)
    }
}
