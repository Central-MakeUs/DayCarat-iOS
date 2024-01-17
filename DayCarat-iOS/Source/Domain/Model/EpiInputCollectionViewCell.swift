//
//  EpiInputCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import UIKit

class EpiInputCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpiInputCollectionViewCell"
    
    private let titleLabel = DayCaratLabel(type: .Body1, text: "제목", textColor: .black)
    private let titleInput = UITextField().then {
        $0.backgroundColor = .white
        $0.placeholder = " 내용을 입력해주세요."
    }
    private let dateLabel = DayCaratLabel(type: .Body1, text: "날짜", textColor: .black)
    private let tagLabel = DayCaratLabel(type: .Body1, text: "활동 태그", textColor: .black)
    private let tagInput = UITextField().then {
        $0.backgroundColor = .white
        $0.placeholder = " ex. 동아리, 인턴"
    }
    private let writeLabel = DayCaratLabel(type: .Body1, text: "작성 항목", textColor: .black)
    private let writeInput = UITextField().then {
        $0.backgroundColor = .white
        $0.placeholder = " 작성항목을 선택해주세요"
    }
    
    private func layout() {
        [titleLabel, titleInput, dateLabel, tagLabel, tagInput, writeInput, writeLabel].forEach {
            self.addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(46)
            $0.leading.equalToSuperview().offset(28)
        }
        titleInput.snp.makeConstraints {
            $0.top.equalToSuperview().offset(46)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(39)
            $0.leading.equalToSuperview().offset(28)
        }
        tagLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(38)
            $0.leading.equalToSuperview().offset(22)
        }
        tagInput.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(25)
            $0.leading.equalTo(tagLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        writeLabel.snp.makeConstraints {
            $0.top.equalTo(tagLabel.snp.bottom).offset(43)
            $0.leading.equalToSuperview().offset(22)
        }
        writeInput.snp.makeConstraints {
            $0.top.equalTo(tagInput.snp.bottom).offset(16)
            $0.leading.equalTo(tagLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
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
