//
//  EpiListModel.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/29/24.
//

import Foundation

import RxDataSources

enum EpiListType {
    case epi
    case gem
}

struct EpisodeSection {
    var items: [Item]
}

extension EpisodeSection: SectionModelType {
    typealias Item = ActivityEpiQuantityDTO

    init(original: EpisodeSection, items: [Item]) {
        self = original
        self.items = items
    }
}
