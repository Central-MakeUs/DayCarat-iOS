//
//  GemDTO.swift
//  DayCarat-iOS
//
//  Created by Choi on 1/26/24.
//

import Foundation

struct ClipboardDTO: Decodable {
    let content: String
}

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

struct AiRecommandDTO: Decodable {
    let generatedContentId: Int
    let generatedContent1: String
    let generatedContent2: String
    let generatedContent3: String
}

struct SoaraInputDTO: Decodable {
    let gemId: Int
    let content1: String?
    let content2: String?
    let content3: String?
    let content4: String?
    let content5: String?
}
extension SoaraInputDTO {
    var nonNullSoaraTypes: [SoaraType] {
        let contents = [content1, content2, content3, content4, content5]
        var soaraTypes: [SoaraType] = []

        for (index, content) in contents.enumerated() {
            if content != nil {
                if let soaraType = SoaraType.from(index: index) {
                    soaraTypes.append(soaraType)
                }
            }
        }
        return soaraTypes
    }
}
