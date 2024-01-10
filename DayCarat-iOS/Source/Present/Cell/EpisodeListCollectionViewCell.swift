//
//  EpisodeListCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/10/24.
//

import UIKit

class EpisodeListCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpisodeListCollectionViewCell"
    private let titleLabel = DayCaratLabel(type: .Subhead4, text: "기획회의", textColor: .black)
    private let dateLabel = DayCaratLabel(type: .Body3, text: "12/15", textColor: .Gray500!)
    private let desLabel = DayCaratLabel(type: .Body3, text: "배운 점 / 팀원 간의 소통에 있어 부족한 부분이 많이 보여 PM으로서 이를 해결하는 방법에 대한 ...", textColor: .Gray500!).then {
        $0.numberOfLines = 0
    }
    
    private func addView() {
        [titleLabel, dateLabel, desLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(16)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(18)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.Gray200?.cgColor
        self.layer.cornerRadius = 16
        addView()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
