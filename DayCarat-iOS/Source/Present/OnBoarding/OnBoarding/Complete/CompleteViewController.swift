//
//  CompleteViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

import RxSwift
import RxCocoa

class CompleteViewController: BaseViewController {
    
    private var disposeBag = DisposeBag()
    private let img = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "onBoardingComplete")
    }
    weak var coordinator: CompleteCoordinator?

    private let titleLabel = DayCaratLabel(type: .Subhead2, text: "데이캐럿을 사용할 준비가 되었어요!", textColor: .Gray800!)
    private let desLabel = DayCaratLabel(type: .Body1, text: "데이캐럿과 함께\n하루하루 보석을 캐고 다듬어 나가요!", textColor: .Gray600!)
    private let completBtn = DayCaratBtn(type: .Sub, text: "메인 홈으로 이동")
    
    deinit {
        coordinator?.popVC()
    }
    
    override func configure() {
        desLabel.textAlignment = .center
    }
    
    override func addView() {
        [img, titleLabel, desLabel, completBtn].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        img.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(181)
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(img.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        completBtn.snp.makeConstraints {
            $0.top.equalTo(desLabel.snp.bottom).offset(39)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func binding() {
        completBtn.rx.tap
            .subscribe(onNext: {  [weak self]  _ in
                self?.coordinator?.pushMain()
            })
            .disposed(by: disposeBag)
    }
}
