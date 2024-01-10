//
//  IntroViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/05.
//

import UIKit

import RxSwift
import RxCocoa

final class IntroViewController: BaseViewController {
    
    private let viewModel: IntroViewModel
    private let disposeBag = DisposeBag()
    weak var coordinator: IntroCoordinator?

    private let introCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(IntroCollectionViewCell.self,
                    forCellWithReuseIdentifier: IntroCollectionViewCell.identifier)
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
    }
    
    private let pageControl = CustomPageControlView(numberOfPages: 3, width: 6, height: 6, spacing: 8, different: true)
    
    private let nextBtn = DayCaratBtn(type: .Default, text: "데이캐럿으로 커리어 관리 시작하기")
    
    
    init(viewModel: IntroViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        coordinator?.popVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let layout = introCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: introCollectionView.bounds.width, height: introCollectionView.bounds.height)
        }
    }
    
    override func configure() {
        self.view.backgroundColor = .Gray50
        self.introCollectionView.delegate = self
        nextBtn.isHidden = true
    }
    
    override func addView() {
        [pageControl, introCollectionView, nextBtn].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        pageControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(6)
        }
        introCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(pageControl.snp.bottom).offset(32)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
        nextBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func binding() {
        let input = IntroViewModel.Input()
        let output = viewModel.transform(input: input)

        output.introCellData
            .asDriver(onErrorDriveWith: .empty())
            .map { data -> [(String, String, UIImage?)] in
                return zip(zip(data.titleData, data.desData), data.image)
                    .map { ($0.0, $0.1, $1) }
            }
            .drive(introCollectionView.rx
                .items(cellIdentifier: IntroCollectionViewCell.identifier, cellType: IntroCollectionViewCell.self)) { index, data, cell in
                    cell.configureCell(titleLabel: data.0, desLabel: data.1, img: data.2)
            }
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.pushOnBoarding()
            })
            .disposed(by: disposeBag)
        
    }
}
extension IntroViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: introCollectionView.contentOffset, size: introCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = introCollectionView.indexPathForItem(at: visiblePoint) {
            let currentIndex = indexPath.item
            
            UIView.animate(withDuration: 0.4) {
                if currentIndex == 2 {
                    self.nextBtn.isHidden = false
                    self.nextBtn.alpha = 1.0
                    
                } else {
                    self.nextBtn.alpha = 0.5
                    self.nextBtn.isHidden = true

                }
                self.pageControl.setCurrentPage(currentIndex)
            }
        }
    }
}
