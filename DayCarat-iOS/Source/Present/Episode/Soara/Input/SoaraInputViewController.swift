//
//  SoaraInputViewController.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/24.
//

import UIKit

import RxSwift
import RxCocoa

final class SoaraInputViewController: BaseViewController {

    //MARK: - Properties

    private let viewModel: SoaraInputViewModel
    private var disposeBag = DisposeBag()
    private let epiData = BehaviorRelay<[String]>(value: [])
    private var textData: String?
    private let type: SoaraType

    //MARK: - UI
    
    private let naviBar = CustomNavigaitonBar(btnstate: true, rightBtnText: "완료", middleText: "")
    private let titleLabel = DayCaratLabel(type: .Subhead4, text: "", textColor: .Gray900!)
    private let desLabel = DayCaratLabel(type: .Body3, text: "해당 에피소드의 상황을 구체적으로 적어주세요", textColor: .Gray500!)
    private let textCountLabel = DayCaratLabel(type: .Body3, text: "0/200", textColor: .Gray600!)
    private let textView = UITextView().then {
        $0.text = " 내용을 입력해주세요."
        $0.textColor = .lightGray
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
    }
    
    //MARK: - LifeCycle
    
    init(viewModel: SoaraInputViewModel, title: String, type: SoaraType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
    }
    
    override func configure() {
        naviBar.delegate = self
        textView.delegate = self
    }
    
    override func addView() {
        self.view.addSubview(naviBar)
        [titleLabel, desLabel, textCountLabel, textView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func layout() {
        naviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(42)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        desLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        textCountLabel.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(93)
            $0.trailing.equalToSuperview().inset(16)
        }
        textView.snp.makeConstraints {
            $0.top.equalTo(textCountLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(330)
        }
    }
        
    override func binding() {
        textView.rx.text.orEmpty
            .bind(onNext: {  [weak self]  text in
                if text.count < 200 {
                    self?.textCountLabel.text = String("\(text.count)/200")
                    self?.textCountLabel.textColor = .Gray600
                    //self?.viewModel.inputData.accept((text, self?.type) as? (String, SoaraType))
                    self?.textData = text
                } else {
                    self?.textCountLabel.text = "200/200"
                    self?.textCountLabel.textColor = .red
                    UIView.animate(withDuration: 0.05, animations: {
                        self?.textCountLabel.transform = CGAffineTransform(translationX: 10, y: 0)
                    }) { _ in
                        UIView.animate(withDuration: 0.05) {
                            self?.textCountLabel.transform = CGAffineTransform.identity
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
        
 
    }
}
//MARK: - Extension

extension SoaraInputViewController: CustomNavigaitonBarDelegate {
    func backBtnClick(_ navibar: CustomNavigaitonBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func rightBtnClick(_ navibar: CustomNavigaitonBar) {
        switch type {
        case .S:
            viewModel.inputSoara(type: type, content1: textData, content2: nil, content3: nil, content4: nil, content5: nil)
        case .O:
            viewModel.inputSoara(type: type, content1: nil, content2: textData, content3: nil, content4: nil, content5: nil)
        case .A:
            viewModel.inputSoara(type: type, content1: nil, content2: nil, content3: textData, content4: nil, content5: nil)
        case .R:
            viewModel.inputSoara(type: type, content1: nil, content2: nil, content3: nil, content4: textData, content5: nil)
        case .LastA:
            viewModel.inputSoara(type: type, content1: nil, content2: nil, content3: nil, content4: nil, content5: textData)
        }
    }
}
extension SoaraInputViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text =  "내용을 입력해주세요."
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        if text == "" {
            return true
        }
        return updatedText.count <= 200
    }
}


