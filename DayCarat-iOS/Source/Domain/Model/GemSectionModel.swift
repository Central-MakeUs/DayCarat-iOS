//
//  GemSectionModel.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 2/10/24.
//

import Foundation

import RxDataSources

enum GemSectionModel {
    case episodeSection(items: [SectionItem])
    case soaraSection(items: [SectionItem])
}

enum SectionItem {
    case episodeItem(DetailEpisodeContentDTO)
    case soaraItem(SoaraInputDTO)
}

extension GemSectionModel: SectionModelType {
    typealias Item = SectionItem

    var items: [SectionItem] {
        switch self {
        case .episodeSection(let items):
            return items
        case .soaraSection(let items):
            return items
        }
    }

    init(original: GemSectionModel, items: [Item]) {
        switch original {
        case .episodeSection:
            self = .episodeSection(items: items)
        case .soaraSection:
            self = .soaraSection(items: items)
        }
    }
}
enum SoaraContent: Int {
    case content1 = 0
    case content2 = 1
    case content3 = 2
    case content4 = 3
    case content5 = 4

    func title() -> String {
        switch self {
        case .content1:
            return "상황 (Situation)"
        case .content2:
            return "목표 (Objective)"
        case .content3:
            return "행동 (Action)"
        case .content4:
            return "결과 (Result)"
        case .content5:
            return "영향 (Aftermath)"
        }
    }
    
    func des() -> String {
        switch self {
        case .content1:
            return "어떤 상황또는 어떤 문제였나요?"
        case .content2:
            return "당시 무엇을 성취하는 것이 목표였나요?"
        case .content3:
            return "목표를 위해 구체적으로 어떤 행동을 하였나요?"
        case .content4:
            return "그로 인해 어떤 결과가 발생했나요?"
        case .content5:
            return "그 결과가 내게 미친 영향은 무엇인가요?"
        }
    }
    
    static func content(forIndex index: Int) -> SoaraContent? {
        return SoaraContent(rawValue: index)
    }
}
