//
//  Video.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 16.05.2022.
//

import Foundation

struct VideoResponse: Codable {
    let items: [VideoKinopoisk]?
}

struct VideoKinopoisk: Codable {
    let url: String?
    let name: String?
    let site: String?
}
