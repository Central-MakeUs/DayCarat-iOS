//
//  RecentEpiCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

import RxSwift

final class RecentEpiCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecentEpiCollectionViewCell"
    var disposeBag = DisposeBag()
    
    private let nameLabel = DayCaratLabel(type: .Subhead6, text: "기획회의", textColor: .black)
    private let desLabel = DayCaratLabel(type: .Body4, text: "n시간전", textColor: .Gray500!)
    
    private let goBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .Gray800
    }

    func configureCell(title: String, date: String) {
        self.nameLabel.text = title
        self.desLabel.text = date
        self.backgroundColor = .clear
    }

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        [nameLabel, desLabel, goBtn].forEach {
            self.addSubview($0)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        goBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.width.equalTo(24)
        }
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Gray200?.cgColor
        self.layer.cornerRadius = 8
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
