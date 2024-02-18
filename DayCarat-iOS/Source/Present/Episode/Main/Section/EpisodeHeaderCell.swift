//
//  EpisodeHeaderCell.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class EpisodeHeaderView: UICollectionReusableView {
    static let identifier = "EpisodeHeaderView"
    var disposeBag = DisposeBag()
    private let searchBtn = UIButton().then {
        $0.setImage(UIImage(named: ""), for: .normal) //icon-search
        $0.tintColor = UIColor(hexString: "#2D3648")
    }
    private let titleLabel = DayCaratLabel(type: .Header5, text: "개의\n원석이 있어요.", textColor: .Gray900!)
    private let desLabel = DayCaratLabel(type: .Body2,
                                         text: "사소한 에피소드도 다시 보면\n자소서에서 활용할 수 있는 보석 같은 경험일 수 있어요", textColor: .Gray700!)
    private let backgroundImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "epiBack")
    }
    
    private let bottomView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    private func addView() {
        self.backgroundColor = .Main50
        [backgroundImg, titleLabel, desLabel, bottomView, searchBtn].forEach {
            self.addSubview($0)
        }
        [activityBtn,dateBtn, yearTableView].forEach {
            self.bottomView.addSubview($0)
        }
    }
    
    var dateBtn = DayCaratToggleBtn(text: "날짜별", state: false).then {
        $0.isEnabled = true
    }
    var activityBtn = DayCaratToggleBtn(text: "활동별", state: true).then {
        $0.isEnabled = true
    }
    
    var yearBtn = UIButton().then {
        $0.layer.borderColor = UIColor.Gray300?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
    }
    
    var yearTableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = .white
        $0.register(YearSelectTableViewCell.self, forCellReuseIdentifier: YearSelectTableViewCell.identifier)
        $0.isScrollEnabled = false
        $0.separatorInset = .zero
    }
    
    func configure(count: String, btnState: Bool) {
        titleLabel.text = "\(count)개의\n원석이 있어요."
    }
    
    func configureBtn(btnState: Bool) {
        if btnState == true {
            activityBtn.backgroundColor = .white
            activityBtn.layer.borderColor = UIColor.Main?.cgColor
            activityBtn.layer.borderWidth = 1
            activityBtn.setTitleColor(.Main, for: .normal)
            dateBtn.backgroundColor = .Gray100
            dateBtn.layer.borderWidth = 0
            dateBtn.setTitleColor(.Gray400, for: .normal)
        } else {
            dateBtn.backgroundColor = .white
            dateBtn.layer.borderColor = UIColor.Main?.cgColor
            dateBtn.layer.borderWidth = 1
            dateBtn.setTitleColor(.Main, for: .normal)
            activityBtn.backgroundColor = .Gray100
            activityBtn.layer.borderWidth = 0
            activityBtn.setTitleColor(.Gray400, for: .normal)
        }
    }
    

    private func layout() {
        backgroundImg.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
            $0.trailing.equalToSuperview().offset(57)
            $0.width.equalTo(197)
            $0.height.equalTo(211)
        }
        searchBtn.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(18)
            $0.trailing.equalToSuperview().offset(-16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(52)
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        bottomView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        activityBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16.5)
            $0.width.equalTo(66)
            $0.height.equalTo(36)
        }
        dateBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(activityBtn.snp.trailing).offset(8)
            $0.width.equalTo(66)
            $0.height.equalTo(36)
        }
        
        yearTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(108)
            $0.height.equalTo(40)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addView()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
