//
//  ViewModelType.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/08.
//

import Foundation

import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
