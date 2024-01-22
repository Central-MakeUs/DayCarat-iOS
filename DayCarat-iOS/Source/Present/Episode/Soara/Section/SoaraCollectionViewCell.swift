//
//  SoaraCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/22/24.
//

import UIKit

final class SoaraCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SoaraCollectionViewCell"

    private let img = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.right")
    }
}
