//
//  AiKeywordView.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/11/24.
//

import Foundation
import UIKit

final class AiKeywordView: UIView {
    
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "불러오는중..", textColor: .black)
    private let dateLabel = DayCaratLabel(type: .Body3, text: "20XX년 X월XX일 X요일", textColor: .Gray500!)
    private let aiKeywordView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray100?.cgColor
    }
    private let dividerView = UIView().then {
        $0.backgroundColor = .Gray300
    }
    private let tagView = UIView().then {
        $0.backgroundColor = .Gray200
        $0.layer.cornerRadius = 4
    }
    private let tagLabel = UILabel().then {
        $0.text = "#CMC"
        $0.font = .pretendard(.Medium, size: 12)
        $0.textColor = .Gray700
    }
    
    
    private let gemImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let keywordTitleLabel = DayCaratLabel(type: .Subhead4, text: "", textColor: .black)
    private let keywordDesLabel = DayCaratLabel(type: .Body3, text: "다른 사람들과 소통방식에 있어 어떤 강점을 발휘했는지 적어보세요", textColor: .Gray600!)
    let keywordEditBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.setTitle("키워드 수정하기", for: .normal)
        $0.tintColor = .Main
        $0.titleLabel?.font = .pretendard(.Medium, size: 15)
        $0.setTitleColor(.main, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.semanticContentAttribute = .forceRightToLeft
    }

    func configure(title: String, dateLabel: String, tag: String, keyword: String, gemImg: UIImage) {
        self.titleLabel.text = title
        self.dateLabel.text = dateLabel
        self.tagLabel.text = "#\(tag)"
        self.keywordTitleLabel.text = keyword
        self.gemImg.image = gemImg
    }
    
    private func addView() {
        self.tagView.addSubview(tagLabel)
        [gemImg, keywordTitleLabel, keywordDesLabel, keywordEditBtn].forEach {
            self.aiKeywordView.addSubview($0)
        }

        [titleLabel, dateLabel, dividerView, aiKeywordView, tagView].forEach {
            self.addSubview($0)
        }
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        tagView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.width.equalTo(61)
            $0.height.equalTo(24)
        }
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        dividerView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        aiKeywordView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(150)
        }
        gemImg.snp.makeConstraints {
            $0.width.height.equalTo(123)
            $0.verticalEdges.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        keywordTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(gemImg.snp.trailing).offset(23)
        }
        keywordDesLabel.snp.makeConstraints {
            $0.top.equalTo(keywordTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(gemImg.snp.trailing).offset(23)
            $0.trailing.equalToSuperview().inset(25)
        }
        keywordEditBtn.snp.makeConstraints {
            $0.top.equalTo(keywordDesLabel.snp.bottom).offset(4)
            $0.leading.equalTo(gemImg.snp.trailing).offset(23)
            $0.width.equalTo(114)
            $0.height.equalTo(21)
        }
    }
    
    func binding() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        layout()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
