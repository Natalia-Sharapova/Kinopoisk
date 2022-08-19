//
//  SerialResponse.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 12.05.2022.
//

import Foundation

struct SerialResponse: Codable {
    let total: Int?
    let items: [Serial]
}

struct Serial: Codable {
    let number: Int?
    let episodes: [Episode]
}

struct Episode: Codable {
    let seasonNumber: Int?
    let episodeNumber: Int?
    let nameRu: String?
    let nameEn: String?
    let synopsis: String?
}
