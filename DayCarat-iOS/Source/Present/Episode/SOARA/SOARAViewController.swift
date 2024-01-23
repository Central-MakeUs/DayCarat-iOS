//
//  SOARAViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/22.
//

import UIKit

import RxSwift
import RxCocoa

final class SOARAViewController: BaseViewController {
    
    
    //MARK: - <##>UI

    private let scrollView = UIScrollView()
    private let contentSV = UIStackView().then {
        $0.axis = .vertical
    }
    private let topView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "", textColor: .Gray900!)
    private let dateLabel = DayCaratLabel(type: .Body3, text: "", textColor: .Gray500!)
    private let epiLabel = DayCaratLabel(type: .Subhead4, text: "에피소드 내용", textColor: .Gray900!)
    private let epiBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .black
    }
    private let lineView = UIView().then {
        $0.backgroundColor = .Gray300
        $0.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    private let epiView = UIView().then {
        $0.backgroundColor = .clear
    }
    //MARK: - LifeCycle
    
    
    
    //MARK: - Method



}
