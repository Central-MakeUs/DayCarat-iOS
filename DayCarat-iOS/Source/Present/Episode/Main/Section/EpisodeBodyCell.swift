//
//  EpisodeBodyCell.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class EpisodeBodyCell: UICollectionViewCell {
    static let identifier = "EpisodeBodyCell"
    
    private let titleLabel = DayCaratLabel(type: .Subhead5, text: "", textColor: .Gray900!)
    private let countLabel = DayCaratLabel(type: .Subhead6, text: "", textColor: .Main!)

    private func addView() {
        [titleLabel, countLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func configure(title: String, count: String) {
        titleLabel.text = title
        countLabel.text = count
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(17.4)
        }
        countLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(17.4)
        }
    }
    
    private func binding() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Gray300?.cgColor
        self.backgroundColor = .Gray50
        addView()
        layout()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
