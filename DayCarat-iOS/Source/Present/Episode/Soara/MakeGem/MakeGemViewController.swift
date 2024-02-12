//
//  MakeGemViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/9/24.
//

import UIKit

import RxSwift
import RxCocoa

final class MakeGemViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: MakeGemViewModel
    private var disposeBag = DisposeBag()
    
    // MARK: - UI
    private let makeGemImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
    }
    
    private let goHomeBtn = DayCaratBtn(type: .Default, text: "메인 홈으로 이동")
    
    // MARK: - LifeCycle

    init(viewModel: MakeGemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    override func configure() {
        
    }
    
    override func addView() {
        [makeGemImg, goHomeBtn].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        makeGemImg.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(163)
            $0.height.equalTo(214)
        }
        goHomeBtn.snp.makeConstraints {
            $0.top.equalTo(makeGemImg.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(88)
        }
    }
    
    override func binding() {
        goHomeBtn.rx
            .tap
            .bind(onNext: {  [weak self] _ in
                self?.viewModel.coordinator?.finish()
                self?.viewModel.coordinator?.goHome()
            })
            .disposed(by: disposeBag)
    }
}
