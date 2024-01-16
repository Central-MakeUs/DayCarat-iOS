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
    func binding() {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.addview()
        self.configure()
        self.layout()
        self.binding()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
