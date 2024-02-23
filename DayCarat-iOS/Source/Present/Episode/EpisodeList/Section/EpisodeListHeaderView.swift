//
//  EpisodeListHeaderView.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/10/24.
//

import UIKit

class EpisodeListHeaderView: UICollectionReusableView {
    static let identifier = "EpisodeListHeaderView"
    
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "활동명", textColor: .Gray900!)
    private let countLabel = DayCaratLabel(type: .Subhead1, text: "12", textColor: .Main!)
    
    func configure(title: String, count: String) {
        titleLabel.text = title
        countLabel.text = count
    }
    
    private func addView() {
        [titleLabel, countLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
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
