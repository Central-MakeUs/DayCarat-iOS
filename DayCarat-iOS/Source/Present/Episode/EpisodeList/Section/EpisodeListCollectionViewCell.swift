//
//  EpisodeListCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/10/24.
//

import UIKit

class EpisodeListCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpisodeListCollectionViewCell"
    private let titleLabel = DayCaratLabel(type: .Subhead4, text: "불러오는중..", textColor: .black)
    private let dateLabel = DayCaratLabel(type: .Body3, text: "...", textColor: .Gray500!)
    private let desLabel = DayCaratLabel(type: .Body3, text: "불러오는중...", textColor: .Gray800!).then {
        $0.numberOfLines = 0
    }
    private let gemImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "purpleGem")
    }
    private var keywordView = KeywordView()
    
    func configure(title: String, date: String, des: String, gem: Bool, type: KeywordViewType, keywordTitle: String) {
        titleLabel.text = title
        dateLabel.text = date
        desLabel.text = des
        if keywordTitle != "미선택" {
            gemImg.isHidden = false
            self.keywordView = KeywordView(title: keywordTitle, type: .keyword)
            self.addSubview(keywordView)
            self.addSubview(gemImg)
            gemImg.snp.makeConstraints {
                $0.top.equalToSuperview().offset(18)
                $0.width.equalTo(24)
                $0.height.equalTo(20)
                $0.trailing.equalToSuperview().inset(20)

            }
            keywordView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(18)
                $0.trailing.equalTo(gemImg.snp.leading).offset(-10)
                $0.height.equalTo(24)
            }
        } else {
            gemImg.isHidden = true
        }
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
