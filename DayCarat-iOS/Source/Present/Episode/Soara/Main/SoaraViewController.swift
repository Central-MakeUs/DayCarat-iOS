//
//  SoaraViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/22/24.
//

import UIKit

import RxSwift
import RxCocoa

final class SoaraViewController: BaseViewController {
    //MARK: - Properties

    private let viewModel: SoaraViewModel
    private var disposeBag = DisposeBag()
    private let epiData = BehaviorRelay<[String]>(value: [])
    weak var coordinator: SoaraCoordinator?
    private var allCellHeight: CGFloat = 0
    private let id: Int

    //MARK: - UI
    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "", middleText: "")
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    private let scrollView = UIScrollView()
    private let contentSV = UIStackView().then {
        $0.axis = .vertical
    }
    private let topView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let titleLabel = DayCaratLabel(type: .Subhead1, text: "dasd", textColor: .Gray900!)
    private let dateLabel = DayCaratLabel(type: .Body3, text: "2020", textColor: .Gray500!)
    private let epiLabel = DayCaratLabel(type: .Subhead4, text: "에피소드 내용", textColor: .Gray900!)
    private let epiBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .black
    }
    private let lineView = UIView().then {
        $0.backgroundColor = .Gray300
    }
    private let soaraLabel = DayCaratLabel(type: .Subhead1, text: "", textColor: .Gray900!)
    private let epiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(DetailEpiBodySection.self, forCellWithReuseIdentifier: DetailEpiBodySection.identifier)
        $0.isScrollEnabled = true
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
    private let soaraView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let soaraTitleLabel = DayCaratLabel(type: .Subhead3, text: "SOARA", textColor: .Gray900!)
    private let soaraImg = UIImageView().then {
        $0.image = UIImage(named: "icon-help-circle")
    }
    private let soaraCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(SoaraCollectionViewCell.self, forCellWithReuseIdentifier: SoaraCollectionViewCell.identifier)
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.sectionInsetReference = .fromContentInset
        layout.itemSize = CGSize(width: 361, height: 47)
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let makeGemBtn = DayCaratBtn(type: .Default, text: "보석 가공하기")
    
    //MARK: - LifeCycle
    
    init(viewModel: SoaraViewModel, coordinator: SoaraCoordinator, id: Int) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.id = id
        self.viewModel.updateDate(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.updateDate(id: self.id)
    }
    
    
    //MARK: - Method
    
    override func configure() {
        epiCollectionView.isHidden = true
        naviBar.delegate = self
        epiCollectionView.delegate = self
        makeGemBtn.isHidden = true
    }
    
    override func addView() {
        self.view.addSubview(naviBar)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentSV)
        [titleLabel, dateLabel, epiLabel, epiBtn].forEach {
            self.topView.addSubview($0)
        }
        [topView, epiCollectionView, lineView, soaraView, makeGemBtn].forEach {
            self.contentSV.addArrangedSubview($0)
        }
        [soaraImg, soaraTitleLabel, soaraCollectionView].forEach {
            self.soaraView.addSubview($0)
        }
    }
    
    override func layout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(42)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.naviBar.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        contentSV.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width) // 추가된 부분
        }
        topView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(146)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.leading.equalToSuperview().offset(16)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
        }
        epiLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        epiBtn.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(24)
            $0.width.height.equalTo(24)
        }
        lineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        soaraView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(379)
        }
        soaraTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(16)
        }
        soaraImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalTo(soaraTitleLabel.snp.trailing).offset(8)
            $0.width.height.equalTo(24)
        }
        soaraCollectionView.snp.makeConstraints {
            $0.top.equalTo(soaraTitleLabel.snp.bottom).offset(24)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(300)
        }
        epiCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            self.collectionViewHeightConstraint = $0.height.equalTo(300).constraint.layoutConstraints.first
        }
        makeGemBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.scrollView.safeAreaLayoutGuide.snp.bottom).inset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func epiHide(completion: @escaping (Bool) -> Void) {
        let isCurrentlyHidden = epiCollectionView.isHidden
        epiCollectionView.isHidden = false
        epiCollectionView.alpha = isCurrentlyHidden ? 0 : 1

        UIView.animate(withDuration: 0.5, animations: {
            self.epiCollectionView.alpha = isCurrentlyHidden ? 1 : 0
        }, completion: { finished in
            self.epiCollectionView.isHidden = !isCurrentlyHidden
            completion(!isCurrentlyHidden)
        })
    }
    
    private func findIndexOfSoaraType(_ type: SoaraType) -> Int? {
        let allTypes: [SoaraType] = [.S, .O, .A, .R, .LastA]
        return allTypes.firstIndex(of: type)
    }
    
    override func binding() {
        
        let input = SoaraViewModel.Input()
        let output = viewModel.transform(input: input)
        
        epiBtn.rx
            .tap
            .asDriver()
            .drive(onNext: {  [weak self] _ in
                self?.epiHide(completion: { isHidden in
                    let newImageName = isHidden ? "chevron.down" : "chevron.up"
                    self?.epiBtn.setImage(UIImage(systemName: newImageName), for: .normal)
                })
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            output.soaraData.asObservable(),
            viewModel.selectedSoara.asObservable().startWith([])
        ) { soaraData, selectedSoara in
            return soaraData.map { soaraType -> (SoaraType, Bool) in
                let isSelected = selectedSoara.contains(where: { $0 == soaraType })
                return (soaraType, isSelected)
            }
        }
        .bind(to: soaraCollectionView.rx.items(cellIdentifier: SoaraCollectionViewCell.identifier, cellType: SoaraCollectionViewCell.self)) { index, model, cell in
            let (soaraType, isSelected) = model
            soaraType.title.drive(onNext: { title in
                cell.configureCell(text: title, isSelected: isSelected)
            }).disposed(by: self.disposeBag)
        }
        .disposed(by: disposeBag)
        
        viewModel.selectedSoara
            .bind(onNext: {  [weak self]  res in
                print("뷰컨========\(res)")
                if res.count == 5 {
                    self?.makeGemBtn.isHidden = false
                }
            })
            .disposed(by: disposeBag)

        soaraCollectionView.rx
            .modelSelected((SoaraType, Bool).self)
            .subscribe(onNext: { [weak self] soaraType, isSelected in
                soaraType.title.drive(onNext: { title in
                    self?.coordinator?.pushInputSoara(title: title, type: soaraType, id: self?.id ?? 0)
                }).disposed(by: self!.disposeBag)
            })
            .disposed(by: disposeBag)
        
        viewModel.epiData
            .bind(onNext: {  [weak self]  res in
                self?.titleLabel.text = res.title
                self?.dateLabel.text = res.selectedDate
            })
            .disposed(by: disposeBag)
        
        viewModel.episodeContents
            .map { $0.map { $0.content } }
            .subscribe(onNext: {  [weak self]  res in
                self?.epiData.accept(res)
            })
            .disposed(by: disposeBag)
        
        viewModel.episodeContents
            .bind(to: self.epiCollectionView.rx.items(cellIdentifier: DetailEpiBodySection.identifier, cellType: DetailEpiBodySection.self))
        {   index, item, cell in
            cell.configure(title: item.episodeContentType, des: item.content)
        }
        .disposed(by: disposeBag)
        
        makeGemBtn.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                print("asdsad")
                self?.coordinator?.registerGem(id: self?.id ?? 0)
            })
            .disposed(by: disposeBag)
        
    }

    func updateCollectionViewHeight() {
        collectionViewHeightConstraint?.constant = allCellHeight + 40
        self.epiCollectionView.layoutIfNeeded()
    }
}
extension SoaraViewController: CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar: CustomNavigaitonBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightBtnClick(_ navibar: CustomNavigaitonBar) {
        
    }
}
extension SoaraViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = epiData.value
        let item = items[indexPath.item]
        let cell = DetailEpiBodySection()
        cell.configureDes(des: item)
        cell.layoutIfNeeded()
        let cellHeight = cell.desLabel.intrinsicContentSize.height + 32
        allCellHeight += cellHeight
        self.updateCollectionViewHeight()
        return CGSize(width: UIScreen.main.bounds.width, height: cellHeight)
    }
}
