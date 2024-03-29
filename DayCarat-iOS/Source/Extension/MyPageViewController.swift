//
//  MyPageViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/9/24.
//

import UIKit

import RxSwift
import RxCocoa
import Kingfisher

final class MyPageViewController: BaseViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    private var disposeBag = DisposeBag()
    private let viewModel: MyPageViewModel
    var appCoordinator: (any Coordinator)?

    private let imgPickerController = UIImagePickerController()
    private let profileImg = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 35
        $0.layer.borderWidth = 1.5
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.Gray200?.cgColor
    }
    private let nickNameLabel = DayCaratLabel(type: .Subhead3, text: "", textColor: .black)
    private let emailLabel = DayCaratLabel(type: .Body5, text: "", textColor: .Gray600!)
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
    
    init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchInfo()

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
        
        
        
        Observable.just(["로그아웃", "회원탈퇴"])
            .bind(to: infoTableView.rx.items(cellIdentifier: MyPageInfoSection.identifier, cellType:MyPageInfoSection.self))
        {  index, item, cell in
            cell.configure(title: item)
        }
        .disposed(by: disposeBag)
        
        infoTableView.rx
            .modelSelected(String.self)
            .bind(onNext: {  [weak self]  str in
                if str == "로그아웃" {
                    self?.viewModel.coordinator?.finish()
                    let navigaitonController = UINavigationController()
                    self?.appCoordinator = AppCoordinator(navigationController: navigaitonController)
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    self?.appCoordinator = AppCoordinator(navigationController: navigaitonController)
                    self?.appCoordinator?.start()
                    sceneDelegate?.window?.rootViewController = navigaitonController
                    sceneDelegate?.window?.makeKeyAndVisible()
                } else {
                    self?.viewModel.deleteUser()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.userData
            .bind(onNext: {  [weak self] info in
                self?.nickNameLabel.text = info.nickname
                //self?.emailLabel.text = info.email
                if let imageURL = URL(string: info.profileImage ?? "") {
                    self?.profileImg.kf.setImage(with: imageURL)
                }
            })
            .disposed(by: disposeBag)
        
        editBtn.rx
            .tap
            .bind(onNext: {
                self.imgPickerController.delegate = self
                self.imgPickerController.sourceType = .photoLibrary
                self.present(self.imgPickerController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage {
            DispatchQueue.main.async {
                self.viewModel.registerImg(img: image)
                self.profileImg.image = image
            }
        }
        self.dismiss(animated: true)
    }
    
}
extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}
