//
//  EpisodeHeaderView.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

import RxSwift
import RxCocoa

final class EpisodeHeaderView: BaseView {
    static let identifier = "EpisodeHeaderCell"
    var disposeBag = DisposeBag()
    private let searchBtn = UIButton().then {
        $0.setImage(UIImage(named: "icon-search"), for: .normal)
        $0.tintColor = UIColor(hexString: "#2D3648")
    }
    private let titleLabel = DayCaratLabel(type: .Header5, text: "123개의\n원석이 있어요.", textColor: .Gray900!)
    private let desLabel = DayCaratLabel(type: .Body2,
                                         text: "사소한 에피소드도 다시 보면\n자소서에서 활용할 수 있는 보석 같은 경험일 수 있어요", textColor: .Gray700!)
    private let bottomView = UIView().then {
        $0.backgroundColor = .Gray50
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    private func addView() {
        self.backgroundColor = .Main100
        [titleLabel, desLabel, bottomView].forEach {
            self.addSubview($0)
        }
    }
    
     override func layout() {
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(18)
            $0.trailing.equalToSuperview().offset(-16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        bottomView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
    
    override func binding() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        layout()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
