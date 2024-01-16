//
//  DetailEpiBodySection.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/12.
//

import UIKit

import RxSwift
import RxCocoa

final class DetailEpiBodySection: UICollectionViewCell {
    static let identifier = "DetailEpiBodySection"
    
    private let titleLabel = DayCaratLabel(type: .Subhead5, text: "", textColor: .black)

    let desLabel = UILabel().then {
        $0.font = .pretendard(.Medium, size: 15)
        $0.textColor = .Gray600
        $0.textAlignment = .justified
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(title: String, des: String) {
        titleLabel.text = title
        desLabel.text = des
    }
    func configureDes(des: String) {
        desLabel.text = des
    }
    
    private func addView() {
        [titleLabel, desLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        desLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.leading.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 30)
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
         layoutIfNeeded()
         let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
         var newFrame = layoutAttributes.frame
         newFrame.size.height = ceil(size.height)
         layoutAttributes.frame = newFrame
         return layoutAttributes
     }
    
    private func binding() {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        layout()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
