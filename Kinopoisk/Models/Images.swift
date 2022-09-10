//
//  Images.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 20.05.2022.
//

import Foundation

struct Images: Codable {
    let total: Int?
    let items: [VideoImages]
}

struct VideoImages: Codable {
    let imageUrl: String?
}
