//
//  CustomNavigaitonBar.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/10/24.
//

import UIKit

import SnapKit
import Then

final class CustomNavigaitonBar: UINavigationBar {
    convenience init(rigthBtn: Bool, rightBtnText: String = "", middleText: String = "") {
        self.init(frame: .zero)
        configure(rigthBtn: rigthBtn, rightBtnText: rightBtnText, middleText: middleText)
    }
    private func configure(rigthBtn: Bool, rightBtnText: String = "", middleText: String = "") {
        self.backItem?.title = ""
        self.topItem?.title = middleText
    }
}
