//
//  dummy.swift
//  DayCarat-iOS
//
//  Created by Choi on 2024/01/10.
//

import Foundation
import RxDataSources

struct SectionModel {
    var items: [Int]
}

extension SectionModel: SectionModelType {
    init(original: SectionModel, items: [Int]) {
        self = original
        self.items = items
    }
}

