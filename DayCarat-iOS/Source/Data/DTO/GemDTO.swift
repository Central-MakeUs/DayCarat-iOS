//
//  GemDTO.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import Foundation

struct GemCountDTO: Decodable {
    let gemCount: Int
}

struct GemKeywordDTO: Decodable {
    let communication: Int
    let conflictResolution: Int
    let passion: Int
    let diligence: Int
    let collaboration: Int
    let leadership: Int
    let feedback: Int
    let unset: Int
}

struct GemMostActivityDTO: Decodable {
    let activityTag: String
}

struct GemMostKeyword: Decodable {
    let episodeKeyword: String
}
