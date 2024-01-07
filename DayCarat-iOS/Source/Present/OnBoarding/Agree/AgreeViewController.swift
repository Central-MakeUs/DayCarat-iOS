//
//  AgreeViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/7/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxGesture

class AgreeViewController: BaseViewController {
    
    private let titleLabel = DayCaratLabel(type: .Header6, text: "약관에 동의해주세요", textColor: .black)
    private let desLabel = DayCaratLabel(type: .Body2, text: "어쩌구저쩌구\n설명", textColor: .gray500)
    private let startBtn = DayCaratBtn(type: .Default, text: "동의하고 시작하기")
    private var tempBaggage: BehaviorRelay<Bool>!
    private var allAgreeView: DayCaratCheckBox?
    private var serviceAgreeView: DayCaratCheckBox?
    private var ageAgreeView: DayCaratCheckBox?
    private var infoAgreeView: DayCaratCheckBox?

    override func configure() {
        tempBaggage = BehaviorRelay(value: false)
        allAgreeView = DayCaratCheckBox(baggage: tempBaggage.asObservable(), text: "전체 약관에 동의합니다.", textType: .Body1, btnType: .Default)
        serviceAgreeView = DayCaratCheckBox(baggage: tempBaggage.asObservable(), text: "서비스 이용약관(필수)", textType: .Body3, btnType: .All)
        ageAgreeView = DayCaratCheckBox(baggage: tempBaggage.asObservable(), text: "만 14세 이상입니다.(필수)", textType: .Body3, btnType: .All)
        infoAgreeView = DayCaratCheckBox(baggage: tempBaggage.asObservable(), text: "개인정보 처리방침 동의(필수)", textType: .Body3, btnType: .All)
    }
    
    override func addView() {
        [titleLabel, desLabel, startBtn].forEach {
            self.view.addSubview($0)
        }
        [allAgreeView!, serviceAgreeView!, ageAgreeView!, infoAgreeView!].forEach {
            self.view.addSubview($0)
        }

    }
    
    override func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        startBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
        allAgreeView!.snp.makeConstraints {
            $0.bottom.equalTo(startBtn.snp.top).offset(-176)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(336)
            $0.height.equalTo(24)
        }
        serviceAgreeView!.snp.makeConstraints {
            $0.top.equalTo(allAgreeView!.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(336)
            $0.height.equalTo(24)
        }
        ageAgreeView!.snp.makeConstraints {
            $0.top.equalTo(serviceAgreeView!.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(336)
            $0.height.equalTo(24)
        }
        infoAgreeView!.snp.makeConstraints {
            $0.top.equalTo(ageAgreeView!.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(336)
            $0.height.equalTo(24)
        }
    }
    
    override func binding() {
        allAgreeView?.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.tempBaggage.accept(!(self?.tempBaggage.value ?? false))
                print("클릭")
            })
            .disposed(by: DisposeBag())
    }
}

