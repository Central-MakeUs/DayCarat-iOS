//
//  BaseViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class BaseViewController: UIViewController {
    
    func layout() {}
    func configure() {}
    func addView() {}
    func binding() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.configure()
        self.addView()
        self.binding()
        self.layout()
    }
}
