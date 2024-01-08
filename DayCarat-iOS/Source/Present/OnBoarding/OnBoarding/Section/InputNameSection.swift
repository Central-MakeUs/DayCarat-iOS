//
//  InputNameSection.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import UIKit

import RxSwift
import RxCocoa

class InputNameSection: BaseView {
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "앞으로 어떻게 불러드릴까요?", textColor: .Gray800!)
    private let desLabel = DayCaratLabel(type: .Body1, text: "데이캐럿에서 사용할 닉네임을 설정해주세요.", textColor: .Gray600!)
    private let disposeBag = DisposeBag()
    let textDidChangeSubject = PublishSubject<String>()

    lazy var inputTextFeild = UITextField().then {
        $0.placeholder = " 입력해주세요."
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray200?.cgColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.addLeftPadding()
    }
    
    lazy var countLabel = UILabel().then {
        $0.text = "0/10"
        $0.textColor = .Gray400
    }
    
    override func addview() {
        [titleLabel, desLabel, inputTextFeild, countLabel].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .clear
    }
    
    override func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        inputTextFeild.snp.makeConstraints {
            $0.top.equalTo(desLabel.snp.bottom).offset(159)
            $0.horizontalEdges.equalToSuperview().inset(32)
            $0.height.equalTo(48)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalTo(inputTextFeild.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(33)
        }
    }
    
    override func binding() {
        self.inputTextFeild.rx.text.orEmpty
            .map {String($0.prefix(11)) }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] truncatedText in
                if truncatedText.count <= 10 {
                    self?.countLabel.text = "\(truncatedText.count)/10"
                    self?.textDidChangeSubject.onNext(truncatedText)

                } else {
                    UIView.animate(withDuration: 0.05, animations: {
                        self?.inputTextFeild.transform = CGAffineTransform(translationX: 10, y: 0)
                    }) { _ in
                        UIView.animate(withDuration: 0.05) {
                            self?.inputTextFeild.transform = CGAffineTransform.identity
                        }
                    }
                    self?.inputTextFeild.text = truncatedText

                }
            })
            .disposed(by: self.disposeBag)
    }
}
    

