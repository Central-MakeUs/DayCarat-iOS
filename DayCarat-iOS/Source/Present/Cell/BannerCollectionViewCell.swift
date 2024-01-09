//
//  BannerCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

import RxSwift

final class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    var disposeBag = DisposeBag()
    
    private let Img = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    func configureCell(img: String) {
        self.Img.image = UIImage(named: img)
    }

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.addSubview(Img)
        Img.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
