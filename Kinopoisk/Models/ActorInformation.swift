//
//  ActorInformation.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 26.05.2022.
//

import Foundation

struct ActorInformation: Codable {
    let age: Int?
    let birthday: String?
    let birthplace: String?
    let films: [ActorsFilms]
    let nameRu: String?
    let personId: Int?
    let posterUrl: String?
    let profession: String?
}

struct ActorsFilms: Codable {
    let description: String?
    let filmId: Int?
    let nameRu: String?
    let rating: String?
}
