//
//  LoginViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    
    weak var coordinator: LoginCoordinator?
    private var disposeBag = DisposeBag()
    
    private let backgroundImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "LoginBackground")
    }
    
    private let titleLabel = DayCaratLabel(type: .Header5, text: "데이캐럿에서\n내 경험들을\n발굴하고 다듬어요", textColor: .white)
    
    private let kakaoBtn = UIButton().then {
        $0.setImage(UIImage(named: "kakoLoginBtn"), for: .normal)
    }
    
    private let appleBtn = UIButton().then {
        $0.setImage(UIImage(named: "AppleLoginBtn"), for: .normal)
    }

    override func configure() {
        kakaoBtn.isUserInteractionEnabled = true
        appleBtn.isUserInteractionEnabled = true

    }
    
    override func addView() {
//        self.view.addSubview(backgroundImg)
        [backgroundImg, titleLabel, appleBtn, kakaoBtn].forEach {
            self.view.addSubview($0) }
    }
    
    override func layout() {
       backgroundImg.snp.makeConstraints {
            $0.edges.equalToSuperview()
       }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        appleBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-70)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(368)
            $0.height.equalTo(44)
        }
        kakaoBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.appleBtn.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(368)
            $0.height.equalTo(44)
        }
    }
    
    override func binding() {
        appleBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.pushIntro()
            })
            .disposed(by: disposeBag)

        kakaoBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.pushIntro()
            })
            .disposed(by: disposeBag)
    }
}
