//
//  BaseView.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/7/24.
//

import UIKit

import SnapKit
import Then

class BaseView: UIView {
    func layout() {}
    func configure() {}
    func addview() {}
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addview()
        self.configure()
        self.layout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
