//
//  File.swift
//  DayCarat-iOS
//
//  Created by Choi on 2/6/24.
//

import Foundation
import UIKit

enum KeywordViewType {
 case primary
 case keyword
}
final class KeywordView: UIView {
    private let title = UILabel().then {
        $0.text = ""
        $0.font = .pretendard(.Medium, size: 12)
        $0.sizeToFit()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.addSubview(title)
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configure(title: String, type: KeywordViewType) {
        self.title.text = title
        self.title.textColor = .Main
        self.layer.cornerRadius = 4
        switch type {
        case .primary:
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.Main?.cgColor
            self.backgroundColor = .white
        case .keyword:
            self.backgroundColor = .Main100
        }
    }
}
