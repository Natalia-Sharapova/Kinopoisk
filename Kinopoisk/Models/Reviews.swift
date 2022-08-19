//
//  Reviews.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 20.05.2022.
//

import Foundation

struct Reviews: Codable {
    let items: [VideoReview]
}

struct VideoReview: Codable {
    let kinopoiskId: Int?
    let type: String?
    let date: String?
    let positiveRating: Int?
    let negativeRating: Int?
    let author: String?
    let title: String?
    let description: String?
}
