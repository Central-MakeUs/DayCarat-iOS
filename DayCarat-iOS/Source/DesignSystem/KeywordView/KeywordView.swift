//
//  File.swift
//  DayCarat-iOS
//
//  Created by Choi on 2/6/24.
//

import UIKit

enum KeywordViewType {
 case primary
 case keyword
}

final class KeywordView: UIView {
    
    private let title = UILabel().then {
         $0.text = ""
         $0.font = .pretendard(.Medium, size: 12)
         $0.numberOfLines = 1
         $0.sizeToFit()
     }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    convenience init(title: String, type: KeywordViewType) {
        self.init()
        configure(title: title, type: type) 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(title)
        
        title.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(3) // 좌측 여백
            make.trailing.lessThanOrEqualToSuperview().offset(-3) // 우측 여백
        }
        
        
        self.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(60) // 최소 넓이 설정
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
