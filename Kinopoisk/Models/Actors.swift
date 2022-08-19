//
//  Actors.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 17.05.2022.
//

import Foundation

struct Actors: Codable {
    let staffId: Int?
    let nameRu: String?
    let nameEn: String?
    let description: String?
    let posterUrl: String?
    let professionKey: String?
    let professionText: String?
}
