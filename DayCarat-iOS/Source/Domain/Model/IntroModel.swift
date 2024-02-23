//
//  IntroModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import Foundation
import UIKit

struct IntroCellData {
    let titleData: [String] = ["간편하게 기록하는\n내 커리어 경험", "경험들을 다듬어\n보석으로", "알림을 통해 내 경험들을\n돌아보는 습관 기르기"]
    let desData: [String] = ["매 활동마다 간단하게\n나의 커리어 에피소드를 기록할 수 있어요", "간단하게 기록했던 커리어 에피소드(원석)를\n데이캐럿만의 페이지를 통해 더욱 자세히 작성할 수 있어요", "아직 다듬지 않은 커리어 에피소드를 자세히 기록하고,\n관리할 수 있도록 알림을 보내드려요."]
    let image: [UIImage?] = [UIImage(named: "OnBoarding1"), UIImage(named: "OnBoarding2"), UIImage(named: "OnBoarding3")]
}
