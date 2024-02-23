//
//  EpiInputFooterView.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/21/24.
//

import UIKit

import RxSwift

final class EpiInputFooterView: UICollectionReusableView {
    static let identifier = "EpiInputFooterView"
    
    let addBtn = DayCaratBtn(type: .Jump, text: "작성항목 추가")
    
    private func layout() {
        self.addSubview(addBtn)
        addBtn.snp.makeConstraints {
            $0.width.equalTo(360)
            $0.height.equalTo(48)
            $0.center.equalToSuperview()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
