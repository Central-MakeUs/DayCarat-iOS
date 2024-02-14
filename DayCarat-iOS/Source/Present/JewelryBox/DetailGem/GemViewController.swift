//
//  CreateSoaraViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources
import Toast

final class GemViewController: BaseViewController {
    
    // MARK: - Properties
    private var dataSource: RxCollectionViewSectionedReloadDataSource<DetailEpiSection>!
    private let viewModel: GemViewModel
    private var epiDataSource: RxCollectionViewSectionedReloadDataSource<GemSectionModel>!
    private var disposeBag = DisposeBag()
    private let epiData = BehaviorRelay<[String]>(value: [])
    private let soaraData = BehaviorRelay<[String]>(value: [])
    private var allCellHeight: CGFloat = 0
    private var allSoaraCellHeight: CGFloat = 0
    private var allTableHeight: CGFloat = 0
    private var clipBoardData = ""

    private var collectionViewHeightConstraint: NSLayoutConstraint?
    private var soaraCollectionViewHeightConstraint: NSLayoutConstraint?
    private var tableViewHeightConstraint: NSLayoutConstraint?
    private let type: KeywordEnum
    private let aiData = BehaviorRelay<[String]>(value: [])
    
    //MARK: - UI
    private let scrollView = UIScrollView()
    private let headerInfoView = AiKeywordView().then {
        $0.backgroundColor = .clear
    }
    private let waitImg = UIImageView().then {
        $0.image = UIImage(named: "waitKeyword")
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .Gray100
        $0.layer.cornerRadius = 8
    }
    private let epiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
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
    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "", middleText: "")
    private let contentSV = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 28
    }
    private let dividerView = UIView().then {
        $0.backgroundColor = .Gray300
    }
    private let soaraHeaderView = UIView().then {
        $0.backgroundColor = .clear
    }
    private let soaraTitleLabel = DayCaratLabel(type: .Subhead3, text: "SOARA", textColor: .Gray900!)
    private let soaraImg = UIImageView().then {
        $0.image = UIImage(named: "icon-help-circle")
    }
    private let copyBtn = UIButton().then {
        $0.setImage(UIImage(named: "icon-copy"), for: .normal)
    }
    private let aiRecommandTableView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(AiRecommandableViewCell.self, forCellWithReuseIdentifier: AiRecommandableViewCell.identifier)
        $0.isScrollEnabled = false
        $0.backgroundColor = .Main50
        $0.layer.cornerRadius = 16
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let soaraCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(SoaraList.self, forCellWithReuseIdentifier: SoaraList.identifier)
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.sectionInsetReference = .fromContentInset
        $0.collectionViewLayout = layout
        $0.decelerationRate = .fast
        $0.alwaysBounceVertical = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - LifeCycle
    
    init(viewModel: GemViewModel, id: Int, type: KeywordEnum) {
        self.viewModel = viewModel
        self.type = type
        self.viewModel.updateData(id: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method

    override func configure() {
        self.naviBar.delegate = self
        self.epiCollectionView.delegate = self
        self.soaraCollectionView.delegate = self
        self.aiRecommandTableView.delegate = self
        setupDataSource()
    }
    
    override func addView() {
        self.view.addSubview(naviBar)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentSV)
        [soaraTitleLabel, soaraImg, copyBtn].forEach {
            soaraHeaderView.addSubview($0)
        }
        headerInfoView.addSubview(waitImg)
        [headerInfoView, epiCollectionView, dividerView, soaraHeaderView, aiRecommandTableView, soaraCollectionView].forEach {
            contentSV.addArrangedSubview($0)
        }
    }
    
    override func layout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(42)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        contentSV.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        headerInfoView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(260)
        }
        epiCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            self.collectionViewHeightConstraint = $0.height.equalTo(300).constraint.layoutConstraints.first
        }
        dividerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        soaraTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        soaraImg.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(soaraTitleLabel.snp.trailing).offset(6)
            $0.width.height.equalTo(24)
        }
        copyBtn.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        soaraHeaderView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        }
        aiRecommandTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            self.tableViewHeightConstraint = $0.height.equalTo(300).constraint.layoutConstraints.first

        }
        soaraCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            self.soaraCollectionViewHeightConstraint = $0.height.equalTo(361).constraint.layoutConstraints.first
        }
        waitImg.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    private func setupDataSource() {

        dataSource = RxCollectionViewSectionedReloadDataSource<DetailEpiSection>(
            configureCell: { _, collectionView, indexPath, item in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailEpiBodySection.identifier, for: indexPath) as! DetailEpiBodySection
                cell.configure(title: item.episodeContentType, des: item.content)
                return cell
            }
        )
    }
    
    override func binding() {
        viewModel.episodeContents
            .map { $0.map { $0.content } }
            .subscribe(onNext: {  [weak self]  res in
                self?.epiData.accept(res)
            })
            .disposed(by: disposeBag)
        
        viewModel.detailData
            .bind(onNext: {  [weak self]  res in
                if self?.type.gemTitle == "미선택" {
                    self?.waitImg.isHidden = false

                } else {
                    self?.waitImg.isHidden = true
                }
                self?.headerInfoView.configure(title: res.title, dateLabel: res.selectedDate, tag: res.activityTagName, keyword: self?.type.gemTitle ?? "", gemImg: self?.type.gemBackgroundImg ?? UIImage(named: "Jewelry")!)
            })
            .disposed(by: disposeBag)
        
        viewModel.aiRecommandData
            .subscribe(onNext: {  [weak self]  res in
                self?.aiData.accept(res)
                self?.aiRecommandTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.episodeContents
            .map { [DetailEpiSection(items: $0)] }
            .bind(to: epiCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.soaraContents
            .bind(to: soaraCollectionView.rx.items(cellIdentifier: SoaraList.identifier, cellType: SoaraList.self))
        {  index, item, cell in
            let soaraContent = SoaraContent.content(forIndex: index)
            cell.configureDes(title: soaraContent?.title() ?? "", subtitle: soaraContent?.des() ?? "", des: item)
        }
        .disposed(by: disposeBag)
        
        viewModel.aiRecommandData
            .bind(to: aiRecommandTableView.rx.items(cellIdentifier: AiRecommandableViewCell.identifier, cellType: AiRecommandableViewCell.self))
        {   index, item, cell in
            cell.configure(des: "\(item)")
        }
        .disposed(by: disposeBag)
        
        viewModel.soaraContents
            .bind(onNext: {  [weak self] res in
                self?.soaraData.accept(res)
                self?.soaraCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.clipboardData
            .subscribe(onNext: {  [weak self] res in
                self?.clipBoardData = res.content
            })
            .disposed(by: disposeBag)
        
        copyBtn.rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                if self?.clipBoardData == "" {
                    
                } else {
                    UIPasteboard.general.string = self?.clipBoardData
                    self?.view.makeToast("클립보드 복사 완료!", duration: 1.5, position: .bottom)

                }
            })
            .disposed(by: disposeBag)
    }

    func updateCollectionViewHeight() {
        collectionViewHeightConstraint?.constant = allCellHeight + 40
        self.epiCollectionView.layoutIfNeeded()
    }
    func updateSoaraCollectionViewHeight() {
        soaraCollectionViewHeightConstraint?.constant = allSoaraCellHeight + 40
        self.soaraCollectionView.layoutIfNeeded()
        tableViewHeightConstraint?.constant = allTableHeight + 80
        self.aiRecommandTableView.layoutIfNeeded()
    }
}
//MARK: - Extension
extension GemViewController: UICollectionViewDelegateFlowLayout, UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == epiCollectionView {
            let items = epiData.value
            let item = items[indexPath.item]
            let cell = DetailEpiBodySection()
            cell.configureDes(des: item)
            cell.layoutIfNeeded()
            let cellHeight = cell.desLabel.intrinsicContentSize.height + 32
            allCellHeight += cellHeight
            self.updateCollectionViewHeight()
            return CGSize(width: 360, height: cellHeight)
        } else if collectionView == soaraCollectionView {
            let items = soaraData.value
            let item = items[indexPath.item]
            let cell = SoaraList()
            cell.configureDes(title: "", subtitle: "", des: item)
            cell.layoutIfNeeded()
            let cellHeight = cell.desLabel.intrinsicContentSize.height + 90
            allSoaraCellHeight += cellHeight
            self.updateSoaraCollectionViewHeight()
            return CGSize(width: 360, height: cellHeight)
        } else if collectionView == aiRecommandTableView {
            let items = aiData.value
            let item = items[indexPath.item]
            let cell = AiRecommandableViewCell()
            cell.configure(des: item)
            cell.layoutIfNeeded()
            let cellHeight = cell.desLabel.intrinsicContentSize.height + 10
            allTableHeight += cellHeight
            self.updateSoaraCollectionViewHeight()
            return CGSize(width: 360, height: cellHeight)
        } else {
            return CGSize(width: 0 , height: 0)
        }
    }
}
extension GemViewController: CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar: CustomNavigaitonBar) {
        viewModel.coordinator.popupViewController(animated: true)
    }
    
    func rightBtnClick(_ navibar: CustomNavigaitonBar) {
        
    }
    
    
}
