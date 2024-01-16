//
//  TabBarItem.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/13/24.
//

import UIKit

enum TabBarItem: CaseIterable {
    case home, episode, epiInput, jewerlyBox, mypage
    
    var item: UITabBarItem {
        switch self {
        case .home:
            return .init(title: "홈",
                         image: .init(named: "basehome"), tag: 0)
        case .episode:
            return .init(title: "에피소드",
                         image: .init(named: "basefolder"), tag: 1)

        case .epiInput:
            return .init(title: "", image: nil, tag: 2)

        case .jewerlyBox:
            return .init(title: "보석함",
                         image: .init(named: "basejewelry"), tag: 3)

        case .mypage:
            return .init(title: "마이페이지",
                         image: .init(named: "baseuser"), tag: 4)
        }
    }
}
