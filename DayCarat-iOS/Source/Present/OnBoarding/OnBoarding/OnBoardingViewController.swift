//
//  OnBoardingViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import UIKit

import RxSwift
import RxGesture

final class OnBoardingViewController: BaseViewController {
    
    private let viewModel: OnBoardingViewModel
    private let disposeBag = DisposeBag()
    
    private let pageControl = CustomPageControlView(numberOfPages: 3, width: 87, height: 2, spacing: 4, different: false)
    
    private let onBoardingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(OnBoardingCollectionViewCell.self,
                    forCellWithReuseIdentifier: OnBoardingCollectionViewCell.identifier)
        $0.isScrollEnabled = true
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.backgroundColor = .clear
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
    }
    
    private let jumpBtn = DayCaratBtn(type: .Jump, text: "건너뛰기")
    private var nextBtn = DayCaratBtn(type: .Disabled, text: "다음으로")
    private let btnSV = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.distribution = .equalSpacing
    }
    
    init(viewModel: OnBoardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let layout = onBoardingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: onBoardingCollectionView.bounds.width, height: onBoardingCollectionView.bounds.height)
        }
    }
    
    override func configure() {
        jumpBtn.isHidden = true
        onBoardingCollectionView.delegate = self
        viewModel.updateInfo()

    }
    
    override func addView() {
        [jumpBtn ,nextBtn].forEach {
            self.btnSV.addArrangedSubview($0)
        }
        [pageControl, onBoardingCollectionView, btnSV].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        pageControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(3)
        }
        onBoardingCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-200)
        }
        btnSV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    override func binding() {
        Observable.just([0, 1, 2])
            .bind(to: onBoardingCollectionView.rx.items(cellIdentifier: OnBoardingCollectionViewCell.identifier, cellType: OnBoardingCollectionViewCell.self)){ index, data, cell in
                cell.configureCell(index: index)
                cell.inputNameSection?.textDidChangeSubject
                    .map { $0.count > 0 }
                    .asDriver(onErrorJustReturn: false)
                    .drive(onNext: { [weak self] isEnabled in
                        self?.nextBtn.isEnabled = isEnabled
                    })
                    .disposed(by: cell.disposeBag)
            }
        .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .subscribe(onNext: { [weak onBoardingCollectionView] in
                guard let collectionView = onBoardingCollectionView else { return }

                let currentIndex = collectionView.currentPageIndex()

                let nextIndex = min(currentIndex + 1, 2)

                let nextIndexPath = IndexPath(item: nextIndex, section: 0)
                collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension OnBoardingViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: onBoardingCollectionView.contentOffset, size: onBoardingCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = onBoardingCollectionView.indexPathForItem(at: visiblePoint) {
            let currentIndex = indexPath.item
            
                if currentIndex == 2 {
                    self.jumpBtn.isHidden = false
                    
                } else {
                    self.jumpBtn.isHidden = true
                }
                self.pageControl.setCurrentPage(currentIndex)
            
        }
    }
}

