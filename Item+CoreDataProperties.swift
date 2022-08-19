//
//  Item+CoreDataProperties.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 07.06.2022.
//
//

import Foundation
import CoreData


extension FilmItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FilmItem> {
        return NSFetchRequest<FilmItem>(entityName: "FilmItem")
    }

    @NSManaged public var duration: Int64
    @NSManaged public var filmId: Int64
    @NSManaged public var filmLength: String?
    @NSManaged public var imdbId: String?
    @NSManaged public var kinopoiskId: Int64
    @NSManaged public var nameEn: String?
    @NSManaged public var nameOriginal: String?
    @NSManaged public var nameRu: String?
    @NSManaged public var posterUrl: String?
    @NSManaged public var posterUrlPreview: String?
    @NSManaged public var rating: String?
    @NSManaged public var ratingAgeLimits: String?
    @NSManaged public var ratingFilmCritics: Int64
    @NSManaged public var ratingGoodReview: Int64
    @NSManaged public var ratingImdb: Double
    @NSManaged public var ratingImdbVoteCount: Int64
    @NSManaged public var ratingKinopoisk: Double
    @NSManaged public var ratingKinopoiskVoteCount: Int64
    @NSManaged public var ratingVoteCount: Int64
    @NSManaged public var releaseDate: String?

}

extension FilmItem : Identifiable {

}
