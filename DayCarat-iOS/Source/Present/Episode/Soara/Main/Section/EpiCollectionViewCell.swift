//
//  EpiCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/22/24.
//

import UIKit

import RxSwift
import RxCocoa

final class EpiCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpiCollectionViewCell"
    
    private let titleLabel = DayCaratLabel(type: .Subhead5, text: "", textColor: .black)
    private let desLabel = DayCaratLabel(type: .Body2, text: "", textColor: .black)
    private let img = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
    }

    func configureCell(title: String, des: String) {
        titleLabel.text = title
        desLabel.text = des
    }
    
    private func layout() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
