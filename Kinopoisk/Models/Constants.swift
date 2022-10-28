//
//  Constants.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 28.10.2022.
//

import Foundation

//MARK: - Constants for fetching the data

struct Constants {
     static let API_KEY = "b01710ad-848a-4472-b8b6-b821582511fc"
      // static let API_KEY = "85a6a5c9-9d41-4a0b-a030-303174742d57"
    // static let API_KEY = "4237f1d2-3253-48c4-a9e1-4a09cfc8c39a"
    // static let API_KEY = "2f733ac4-cf57-45e1-b106-479b0ecf6fad"
    static let baseURL = "https://kinopoiskapiunofficial.tech/api/v2.2/films"
    static let YoutubeAPI_KEY = "AIzaSyA2pGulH8anGCS6PRioYhOMeavrC2Qc3DE"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let premiers = "/premieres?year=2022&month=OCTOBER"
    static let bestFilms = "/top?type=TOP_250_BEST_FILMS&page=1"
    static let popularFilms = "/top?type=TOP_100_POPULAR_FILMS&page=1"
    static let bestTvSeries = "?order=NUM_VOTE&type=TV_SERIES&ratingTo=10&yearFrom=1000&yearTo=3000&page=1"
    static let awaitFilms = "/top?type=TOP_AWAIT_FILMS&page=1"
    static let horrors = "?genres=17&order=NUM_VOTE&type=FILM&ratingFrom=0&ratingTo=10&page=1"
    static let detectives = "?genres=5&order=NUM_VOTE&type=FILM&ratingFrom=0&ratingTo=10&page=1"
    static let tvShow = "?order=RATING&type=TV_SHOW&ratingFrom=0&ratingTo=10&yearFrom=1000&yearTo=3000&page=1"
    static let random = "?order=RATING&type=ALL&ratingFrom=0&ratingTo=10&page=1"
    static let films2022 = "?order=RATING&type=FILM&ratingFrom=0&ratingTo=10&yearFrom=2022&yearTo=2022&page=1"
    static let serials2022 = "?order=RATING&type=TV_SERIES&ratingFrom=0&ratingTo=10&yearFrom=2022&yearTo=2022&page=1"
    static let turkishSerials = "?countries=44&order=RATING&type=TV_SERIES&ratingFrom=0&ratingTo=10&page=1"
    static let koreanSerials = "?countries=49&order=RATING&type=TV_SERIES&ratingFrom=0&ratingTo=10&page=1"
    static let actorsURL = "https://kinopoiskapiunofficial.tech/api/v1/staff?filmId"
    static let actorInformation = "https://kinopoiskapiunofficial.tech/api/v1/staff"
}
