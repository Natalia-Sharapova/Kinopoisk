//
//  YoutubeSearchResponse.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 11.05.2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElements]
}

struct VideoElements: Codable {
    let id: Video
}

struct Video: Codable {
    let kind: String
    let videoId: String
}

