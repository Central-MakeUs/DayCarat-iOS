//
//  EpiInputCollectionViewCell.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import UIKit

import RxSwift
import RxCocoa

final class EpiInputCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpiInputCollectionViewCell"
    
    private var disposeBag = DisposeBag()
    private let drowDownItem = BehaviorSubject<[String]>(value: ["자유롭게 작성", "배운 점", "아쉬운 점", "보완할 점"])
    private let writeSV = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    private let writeLabel = DayCaratLabel(type: .Body1, text: "작성 항목", textColor: .black)
    private let writeItmesLabel = DayCaratLabel(type: .Body1, text: "작성 항목 선택", textColor: .Gray400!)
    private let writeView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
        $0.backgroundColor = .white
    }

    let dropDwonBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.tintColor = .Gray800
    }
    let inputTextField = UITextView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
    }
    
    private let dropDwonTabelView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.identifier)
        $0.isScrollEnabled = false
        $0.separatorInset = .zero
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
        $0.separatorStyle = .none
        $0.contentInset = .zero
        $0.sectionHeaderTopPadding = 0
        $0.layer.masksToBounds = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private func layout() {
        self.addSubview(writeSV)
        self.addSubview(inputTextField)
        self.addSubview(dropDwonTabelView)
        dropDwonTabelView.sectionHeaderTopPadding = 1
        [dropDwonBtn, writeItmesLabel].forEach {
            self.writeView.addSubview($0)
        }
        [writeLabel, writeView].forEach {
            self.writeSV.addArrangedSubview($0)
        }
        writeSV.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(writeSV.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        dropDwonBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.trailing.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(12)
        }
        dropDwonTabelView.snp.makeConstraints {
            $0.top.equalTo(writeSV.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(320)
            $0.height.equalTo(180)
        }
        writeView.snp.makeConstraints {
            $0.width.equalTo(281)
            $0.height.equalTo(48)
        }
        writeItmesLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(13)
            $0.verticalEdges.equalToSuperview().inset(13.5)
        }
    }
    
    private func binding() {
        dropDwonBtn.rx
            .tap
            .asDriver()
            .drive(onNext: {  [weak self]  data in
                self?.dropDwonBtn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
                self?.dropDwonTabelView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        drowDownItem
            .bind(to: self.dropDwonTabelView.rx.items(cellIdentifier: DropDownTableViewCell.identifier, cellType: DropDownTableViewCell.self))
        {  index, item, cell  in
            cell.selectionStyle = .none
            cell.configureCell(text: item)
        }
        .disposed(by: disposeBag)
        
        dropDwonTabelView.rx
            .modelSelected(String.self)
            .asDriver()
            .drive(onNext: {  [weak self] data in
                self?.dropDwonBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                self?.dropDwonTabelView.isHidden = true
                self?.writeItmesLabel.text = data
                self?.writeItmesLabel.textColor = .black
            })
            .disposed(by: disposeBag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.dropDwonTabelView.isHidden = true
        dropDwonTabelView.delegate = self
        layout()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EpiInputCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
