//
//  MyPageViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

import RxSwift
import RxCocoa

final class MyPageViewController: BaseViewController {
    
    private var disposeBag = DisposeBag()
    
    private let profileImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 35
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor.Gray200?.cgColor
    }
    private let nickNameLabel = DayCaratLabel(type: .Subhead3, text: "지철", textColor: .black)
    private let emailLabel = DayCaratLabel(type: .Body5, text: "sksk02zja@naver.com", textColor: .Gray600!)
    private let infoTableView = UITableView(frame: CGRect.zero, style: .grouped).then{
        $0.backgroundColor = .clear
        $0.register(MyPageInfoSection.self, forCellReuseIdentifier: MyPageInfoSection.identifier)
        $0.isScrollEnabled = false
        $0.separatorInset = .zero
    }
    private let editBtn = UIButton().then {
        $0.layer.cornerRadius = 18
        $0.backgroundColor = .Main
        $0.setImage(UIImage(named: "icon-edit-3"), for: .normal)
    }
    
    override func configure() {

    }
    
    override func addView() {
        [profileImg, nickNameLabel, emailLabel, infoTableView, editBtn].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        profileImg.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(113)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(72)
        }
        editBtn.snp.makeConstraints {
            $0.bottom.trailing.equalTo(profileImg).offset(4)
            $0.width.height.equalTo(36)
        }
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImg.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        infoTableView.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(85)
            $0.horizontalEdges.equalToSuperview().inset(41)
            $0.height.equalTo(200)
        }
    }
    
    override func binding() {
        infoTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        Observable.just([0, 1])
            .bind(to: infoTableView.rx.items(cellIdentifier: MyPageInfoSection.identifier, cellType:MyPageInfoSection.self))
        {  index, item, cell in
            
        }
        .disposed(by: disposeBag)
    }
}
extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
