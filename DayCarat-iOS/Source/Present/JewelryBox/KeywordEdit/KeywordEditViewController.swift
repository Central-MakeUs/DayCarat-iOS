//
//  KeywordEditViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/19/24.
//

import UIKit

final class KeywordEditViewController: BaseViewController {
    
    // MARK: - Properties

    private let viewModel: KeywordEditViewModel
    
    // MARK: - UI
    
    private let keywordCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(DetailEpiBodySection.self, forCellWithReuseIdentifier: DetailEpiBodySection.identifier)
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 24, left: 20, bottom: 60, right: 16)
        layout.minimumInteritemSpacing = 20
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: - LifeCycle

    init(viewModel: KeywordEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    override func configure() {
        let titleLabel = DayCaratLabel(type: .Subhead5, text: "에피소드 키워드 선택하기", textColor: .black)
        navigationItem.titleView = titleLabel
    }
    
    override func addView() {
        
    }
    
    override func layout() {
        
    }
    
    override func binding() {
        
    }

}
