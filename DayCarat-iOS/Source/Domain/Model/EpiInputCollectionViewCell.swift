//
//  EpiInputCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import UIKit

class EpiInputCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpiInputCollectionViewCell"
    
    private let writeSV = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    private let writeLabel = DayCaratLabel(type: .Body1, text: "작성 항목", textColor: .black)
    private let writeInput = UITextField().then {
        $0.backgroundColor = .white
        $0.placeholder = " 작성항목을 선택해주세요"
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
    }
    let inputTextField = UITextView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
    }
    
    private func layout() {
        self.addSubview(writeSV)
        self.addSubview(inputTextField)
        [writeLabel, writeInput].forEach {
            self.writeSV.addArrangedSubview($0)
        }
        writeSV.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        writeInput.snp.makeConstraints {
            $0.width.equalTo(280)
            $0.height.equalTo(48)
        }
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(writeSV.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
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
