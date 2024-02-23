//
//  DetailEpiModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/12/24.
//

import Foundation

import RxDataSources

struct DetailEpiSection {
    var items: [Item]
}

extension DetailEpiSection: SectionModelType {
    typealias Item = DetailEpisodeContentDTO

    init(original: DetailEpiSection, items: [Item]) {
        self = original
        self.items = items
    }
}
