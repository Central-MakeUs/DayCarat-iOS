//
//  EpiDTO.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/17/24.
//

import Foundation

struct recentEPi: Decodable {
    let id: Int
    let title: String
    let time: String
}

struct epiCount: Decodable {
    let episodeCount: Int
}

struct DetailEpisodeDTO: Decodable {
    let episodeId: Int
    let title: String
    let activityTagName: String
    let selectedDate: String
    let episodeContents: [DetailEpisodeContentDTO]
}

struct DetailEpisodeContentDTO: Decodable {
    let episodeContentId: Int
    let episodeContentType: String
    let content: String
}

struct EpisodeInputContent {
    let episodeContentType: String
    let content: String
}

struct ActivityEpiQuantityDTO: Decodable {
    let activityTagName: String
    let quantity: Int
}
