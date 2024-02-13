//
//  DetailEpiHeaderView.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/12.
//

import UIKit

import SnapKit
import Then

final class DetailEpiHeaderView: UICollectionReusableView {
    static let identifier = "DetailEpiHeaderView"
    
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "", textColor: .black)
    private let dateLabel = DayCaratLabel(type: .Body3, text: "", textColor: .Gray500!)
    private let tagView = UIView().then {
        $0.backgroundColor = .Gray200
        $0.layer.cornerRadius = 4
    }
    private let tagLabel = UILabel().then {
        $0.text = "#"
        $0.font = .pretendard(.Medium, size: 12)
        $0.textColor = .Gray700
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .Gray300
    }
    
    func configure(title: String, date: String, tag: String) {
        titleLabel.text = title
        dateLabel.text = date
        tagLabel.text = tag
    }
    
    private func addView() {
        self.tagView.addSubview(tagLabel)
        [titleLabel, dateLabel, tagView, dividerView].forEach {
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
            $0.width.equalTo(51)
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
    }
    
    private func binding() {
        
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
