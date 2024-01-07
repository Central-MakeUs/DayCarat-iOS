//
//  DayCaratCheckBox.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/7/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

enum checkBoxtype {
    case All
    case Default
}

final class DayCaratCheckBox: UIView {
    private var titleLabel = DayCaratLabel(type: .Header1)
    private var checkImg = UIImageView().then {
        $0.image = UIImage(named: "NoCheckBox")
    }
    private let lookBtn = UIButton().then {
        $0.titleLabel?.font = .pretendard(.Regular, size: 14)
        $0.setTitleColor(.Gray500, for: .normal)
        $0.setTitle("보기", for: .normal)
    }
    
    private let disposeBag = DisposeBag()
    private var baggage: Observable<Bool>

    convenience init(baggage: Observable<Bool>, text: String, textType: DayCaratFontType, btnType: checkBoxtype) {
        self.init(frame: .zero) // Use 'frame' instead of 'coder'
        self.baggage = baggage
        self.titleLabel = DayCaratLabel(type: textType, text: text, textColor: .Gray900!)
        self.layout()
        switch btnType {
            
        case .All:
            lookBtn.isHidden = false
        case .Default:
            lookBtn.isHidden = true
        }
        self.binding()
    }
    
    override init(frame: CGRect) {
        self.baggage = Observable<Bool>.just(false)
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        self.baggage = Observable<Bool>.just(false)
        super.init(coder: coder)
    }
    
    private func layout() {
        [checkImg, titleLabel, lookBtn].forEach {
            self.addSubview($0)
        }
        checkImg.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(checkImg.snp.trailing).offset(8)
        }
        lookBtn.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.equalTo(34)
            $0.height.equalTo(18)
        }
    }
    
    private func binding() {
        self.baggage
            .asObservable()
            .map {  ($0 ) ? true : false}
            .map {   $0 ? "CheckBox" : "NoCheckBox"}
            .map {   UIImage(named: $0) }
            .bind(to: checkImg.rx.image)
            .disposed(by: disposeBag)
    }
}
