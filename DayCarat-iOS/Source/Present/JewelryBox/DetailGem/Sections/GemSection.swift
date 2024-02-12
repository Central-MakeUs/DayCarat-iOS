//
//  GemSection.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/9/24.
//

import Foundation

import RxDataSources

struct MySection {
    var header: String
    var items: [Item]
}

extension MySection: SectionModelType {
    typealias Item = String

    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}
