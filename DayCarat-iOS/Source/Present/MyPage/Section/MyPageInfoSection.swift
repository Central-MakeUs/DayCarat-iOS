//
//  MyPageInfoSection.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

final class MyPageInfoSection: UITableViewCell {
    static let identifier = "MyPageInfoSection"
    
    private let titleLabel = DayCaratLabel(type: .Body1, text: "개인정보 수정", textColor: .black)
    
    private let goBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .black
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(6)
        }
        goBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-6)
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        [titleLabel, goBtn].forEach {
            self.addSubview($0)
        }
        layout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
