//
//  Movie.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 07.05.2022.
//

import Foundation

struct Items: Codable {
    let items: [Item]?
    let films: [Item]?
}

struct Item: Codable {
    let countries: [Country]?
    let duration: Int?
    let genres: [Genre]?
    let kinopoiskId: Int?
    let nameEn: String?
    let nameRu: String?
    let posterUrl: String?
    let posterUrlPreview: String?
    let filmId: Int?
    let filmLength: String?
    let rating: String?
    let ratingVoteCount: Int?
    let imdbId:String?
    let nameOriginal: String?
    let ratingKinopoisk: Double?
    let releaseDate: String?
    let ratingAgeLimits:String?
    let ratingImdbVoteCount: Int?
    let ratingKinopoiskVoteCount: Int?
    let ratingFilmCritics: Int?
    let ratingGoodReview: Int?
    let ratingImdb: Double?
}

struct Country : Codable {
    let country: String
}

struct Genre: Codable {
    let genre: String
}

