//
//  CalnderViewController.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/19/24.
//

import UIKit

import RxSwift
import PanModal

final class CalnderViewController: BaseViewController, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {

    var disposeBag = DisposeBag()
    private let viewModel: EpisodeInputViewModel
    var selectedDate: DateComponents? = nil
    let strDate = PublishSubject<String>()
    private let calenderView = UICalendarView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.wantsDateDecorations = true
        $0.tintColor = .Main
    }
    
    init(viewModel: EpisodeInputViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        calenderView.delegate = self
        reloadDateView(date: Date())
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calenderView.selectionBehavior = dateSelection
    }
    
    override func addView() {
        self.view.addSubview(calenderView)
    }
    
    override func layout() {
        calenderView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(373)
        }
    }
    
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        if let date = Calendar.current.date(from: dateComponents!) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd (E)"
            let formattedDate = dateFormatter.string(from: date)
            strDate.onNext(formattedDate)
            reloadDateView(date: date)
        }
    }
    
    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        calenderView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
    
    override func binding() {
        
    
    }
}
extension CalnderViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(422)
    }
}
