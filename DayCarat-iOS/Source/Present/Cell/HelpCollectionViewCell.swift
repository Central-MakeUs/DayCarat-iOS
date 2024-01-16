//
//  HelpCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/09.
//

import UIKit

import RxSwift

final class HelpCollectionViewCell: UICollectionViewCell {
    static let identifier = "HelpCollectionViewCell"
    var disposeBag = DisposeBag()
    
    private let Img = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    func configureCell(img: String) {
        self.Img.image = UIImage(named: img)
        self.backgroundColor = .clear
    }

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 16
        
        self.addSubview(Img)
        Img.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
