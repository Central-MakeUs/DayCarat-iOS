//
//  EpiInputHeadrView.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/16/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

final class EpiInputHeadrView: UICollectionReusableView {
    static let identifier = "EpiInputHeadrView"
    
    private let titleLabel = DayCaratLabel(type: .Body1, text: "제목", textColor: .black)
    private let titleInput = UITextField().then {
        $0.backgroundColor = .white
        $0.placeholder = " 내용을 입력해주세요."
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
    }
    private let titleSV = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    private let datetitleLabel = DayCaratLabel(type: .Body1, text: "날짜", textColor: .black)
    private let dateLabel = DayCaratLabel(type: .Subhead6, text: "213123", textColor: .black)
    private let tagLabel = DayCaratLabel(type: .Body1, text: "활동 태그", textColor: .black)
    private let tagInput = UITextField().then {
        $0.backgroundColor = .white
        $0.placeholder = " ex. 동아리, 인턴"
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
    }
    private let tagSV = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    private let calendarBtn = UIButton().then {
        $0.setImage(UIImage(named: "icon-calendar"), for: .normal)
        $0.tintColor = .black
    }
    
    private func layout() {
        [titleLabel, titleInput].forEach {
            self.titleSV.addArrangedSubview($0)
        }
        [tagLabel,tagInput].forEach {
            self.tagSV.addArrangedSubview($0)
        }
        [titleSV, tagSV, datetitleLabel, dateLabel, calendarBtn].forEach {
            self.addSubview($0)
        }
        titleInput.snp.makeConstraints {
            $0.width.equalTo(281)
            $0.height.equalTo(48)
        }
        titleSV.snp.makeConstraints {
            $0.top.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().inset(16)
        }
        datetitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleSV.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(52)
        }
        tagSV.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(16)
        }
        tagInput.snp.makeConstraints {
            $0.width.equalTo(281)
            $0.height.equalTo(48)
        }
        calendarBtn.snp.makeConstraints {
            $0.top.equalTo(titleSV.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(28)
            $0.width.height.equalTo(24)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleSV.snp.bottom).offset(26)
            $0.leading.equalTo(datetitleLabel.snp.trailing).offset(26)
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
