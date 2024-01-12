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

    private let desLabel = DayCaratLabel(type: .Body2, text: "", textColor: .Gray600!)
    
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    private func addView() {
        [titleLabel, desLabel].forEach {
            self.addSubview($0)
        }
    }
    
    private func layout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
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
