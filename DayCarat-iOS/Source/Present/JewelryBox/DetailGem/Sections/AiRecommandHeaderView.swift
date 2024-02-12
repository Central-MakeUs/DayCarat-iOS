//
//  AiRecommandView.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/9/24.
//

import UIKit

import RxSwift
import RxCocoa

final class AiRecommandHeaderView: UICollectionReusableView {
    static let identifier = "AiRecommandHeaderView"
    private let soaraTitleLabel = DayCaratLabel(type: .Subhead3, text: "SOARA", textColor: .Gray900!)
    private let soaraImg = UIImageView().then {
        $0.image = UIImage(named: "icon-help-circle")
    }
    private let copyBtn = UIButton().then {
        $0.setImage(UIImage(named: "icon-copy"), for: .normal)
    }
    
    private func addView() {
        [soaraTitleLabel, soaraImg, copyBtn].forEach {
            self.addSubview($0)
        }
    }
    
    private func layout() {
        soaraTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        soaraImg.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(soaraTitleLabel.snp.trailing).offset(6)
            $0.width.height.equalTo(24)
        }
        copyBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
