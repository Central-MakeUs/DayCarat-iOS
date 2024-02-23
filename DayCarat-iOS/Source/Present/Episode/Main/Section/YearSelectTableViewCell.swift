//
//  YearSelectTableViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/16/24.
//

import UIKit

final class YearSelectTableViewCell: UITableViewCell {
    static let identifier = "YearSelectTableViewCell"
    
    let yearLabel = DayCaratLabel(type: .Body1, text: "", textColor: .black)
    
    func configure(year: Int) {
        self.yearLabel.text = String(year)
    }
    
    private func layout() {
        self.addSubview(yearLabel)
        yearLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        layout()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
