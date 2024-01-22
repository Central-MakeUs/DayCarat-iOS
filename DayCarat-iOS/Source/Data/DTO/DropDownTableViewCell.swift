//
//  DropDownTableViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/21/24.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    
    static let identifier = "DropDownTableViewCell"

    
    private var resonNameLabel = UILabel().then{
        $0.text = ""
        $0.font = .pretendard(.Regular, size: 14)
        $0.textColor = .Gray900
    }
    
    func configureCell(text: String) {
        self.resonNameLabel.text = text
    }
    
    private func layout(){
        self.resonNameLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
        }
    }
    
    private func addsubview(){
        self.addSubview(resonNameLabel)
    }
    
    private func configure(){
        self.backgroundColor = .white
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addsubview()
        self.layout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
