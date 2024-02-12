//
//  EpiInputHeadrView.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/16/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import PanModal

final class EpiInputHeadrView: UICollectionReusableView {
    
    static let identifier = "EpiInputHeadrView"
    private var disposeBag = DisposeBag()
    private var viewModel = EpisodeInputViewModel(usecase: EpisodeUseCase(epiRepository: EpisodeRepository(service: EpisodeService()), gemRepository: GemRepository(service: GemService())), coordinator: nil)

    let calendarButtonTap = PublishSubject<Void>()
    let date = PublishRelay<String>()
    let tagSubject = PublishSubject<String>()
    let titleSubject = PublishSubject<String>()

    private let titleLabel = DayCaratLabel(type: .Body1, text: "제목", textColor: .black)
    private let titleInput = UITextField().then {
        $0.backgroundColor = .white
        $0.placeholder = " 내용을 입력해주세요."
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
        $0.addLeftPadding()
    }
    private let titleSV = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    private let datetitleLabel = DayCaratLabel(type: .Body1, text: "날짜", textColor: .black)
    private let dateLabel = DayCaratLabel(type: .Subhead6, text: "", textColor: .black)
    private let tagLabel = DayCaratLabel(type: .Body1, text: "활동 태그", textColor: .black)
    private let tagInput = UITextField().then {
        $0.backgroundColor = .white
        $0.placeholder = " ex. 동아리, 인턴"
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.Gray300?.cgColor
        $0.addLeftPadding()
    }
    private let tagSV = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
    }
    private let calendarBtn = UIButton().then {
        $0.setImage(UIImage(named: "icon-calendar"), for: .normal)
        $0.tintColor = .black
    }
    
    private func layout() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd (E)"
        let todayDateString = dateFormatter.string(from: Date())
        dateLabel.text = todayDateString
        [titleLabel, titleInput].forEach {
            self.titleSV.addArrangedSubview($0)
        }
        [tagLabel,tagInput].forEach {
            self.tagSV.addArrangedSubview($0)
        }
        [titleSV, tagSV, datetitleLabel, dateLabel, calendarBtn].forEach {
            self.addSubview($0)
        }
        titleInput.snp.makeConstraints {
            $0.width.equalTo(281)
            $0.height.equalTo(48)
        }
        titleSV.snp.makeConstraints {
            $0.top.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().inset(16)
        }
        datetitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleSV.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(52)
        }
        tagSV.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(16)
        }
        tagInput.snp.makeConstraints {
            $0.width.equalTo(281)
            $0.height.equalTo(48)
        }
        calendarBtn.snp.makeConstraints {
            $0.top.equalTo(titleSV.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(28)
            $0.width.height.equalTo(24)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleSV.snp.bottom).offset(26)
            $0.leading.equalTo(datetitleLabel.snp.trailing).offset(26)
        }
    }
    
    private func binding() {
        calendarBtn.rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.calendarButtonTap.onNext(())
            })
            .disposed(by: disposeBag)
        
        date
            .bind(onNext: { [weak self]  date in
                self?.dateLabel.text = date
            })
            .disposed(by: disposeBag)
        
        titleInput.rx.text
             .orEmpty
             .filter { !$0.isEmpty }
             .bind(onNext: {  [weak self]  title  in
                 self?.titleSubject.onNext(title)
                 self?.titleInput.layer.borderColor = UIColor.Main?.cgColor
             })
             .disposed(by: disposeBag)
        
        tagInput.rx.text
             .orEmpty
             .filter { !$0.isEmpty }
             .bind(onNext: {  [weak self]  tag  in
                 self?.tagSubject.onNext(tag)
                 self?.tagInput.layer.borderColor = UIColor.Main?.cgColor
             })
             .disposed(by: disposeBag)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        binding()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
