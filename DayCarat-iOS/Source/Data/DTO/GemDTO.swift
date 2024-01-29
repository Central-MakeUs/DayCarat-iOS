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
    let problemSolving: Int
    let creativity: Int
    let challengeSpirit: Int
    let proficiency: Int
    let execution: Int
    let unset: Int
}

struct GemMostActivityDTO: Decodable {
    let activityTag: String
}

struct GemMostKeyword: Decodable {
    let episodeKeyword: String
}

struct GemKeywordEpi: Decodable {
    let episodeId: Int
    let title: String
    let date: String
    let content: String
}
