//
//  APICaller.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 07.05.2022.
//

import Foundation

// Constants for fetching the data

struct Constants {
    static let API_KEY = "b01710ad-848a-4472-b8b6-b821582511fc"
    //static let API_KEY = "85a6a5c9-9d41-4a0b-a030-303174742d57"
    // static let API_KEY = "4237f1d2-3253-48c4-a9e1-4a09cfc8c39a"
    // static let API_KEY = "2f733ac4-cf57-45e1-b106-479b0ecf6fad"
    static let baseURL = "https://kinopoiskapiunofficial.tech/api/v2.2/films"
    static let YoutubeAPI_KEY = "AIzaSyA2pGulH8anGCS6PRioYhOMeavrC2Qc3DE"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    static let premiers = "/premieres?year=2022&month=MAY"
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

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    // MARK: - Properties
    static let shared = APICaller()
    
    private init() {}
    
    // MARK: - Methods
    // MARK: - getAwaitFilms
    func getAwaitFilms(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.awaitFilms) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.films!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getBestFilms
    func getBestFilms(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.bestFilms) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.films!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getBestTvSeries
    func getBestTvSeries(completion: @escaping(Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.bestTvSeries) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getHorrors
    func getHorrors(completion: @escaping(Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.horrors) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else {
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getDetectives
    func getDetectives(completion: @escaping(Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.detectives) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getPremiers
    func getPremiers(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.premiers) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getPopularFilms
    func getPopularFilms(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.popularFilms) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            do {
                let results =  try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.films!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getTvShow
    func getTvShow(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.tvShow) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(#line, String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getRandom
    func getRandom(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.random) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(#line, String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getFilms2022
    func getFilms2022(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.films2022) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(#line, String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getSerials2022
    func getSerials2022(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.serials2022) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else {
                print(#line, String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getTurkishSerials
    func getTurkishSerials(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.turkishSerials) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getKoreanSerials
    func getKoreanSerials(completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + Constants.koreanSerials) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.items!))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - search
    func search(with query: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(query)&page=1") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Items.self, from: data)
                completion(.success(results.films!))
            } catch {
                completion(.failure(APIError.failedToGetData))
                print(#line, String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getTrailer
    func getTrailer(with query: String, completion: @escaping (Result<VideoElements, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                
            } catch {
                completion(.failure(error))
                print(String(describing: error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getSerialSeasonEpisode
    func getSerialSeasonEpisode(with id: Int, completion: @escaping (Result<SerialResponse, Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + "/\(id)/seasons") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(#line, String(describing: error))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(SerialResponse.self, from: data)
                print("serial episode", results)
                completion(.success(results))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getVideo
    func getVideo(with id: Int, completion: @escaping (Result<[VideoKinopoisk], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + "/\(id)/videos") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data else {
                print(#line, String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(VideoResponse.self, from: data)
                
                completion(.success(results.items!))
            } catch {
                completion(.failure(error))
                print(#line, error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getActors
    func getActors(with id: Int, completion: @escaping (Result<[Actors], Error>) -> Void) {
        
        guard let url = URL(string: Constants.actorsURL + "=\(id)") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode([Actors].self, from: data)
                
                completion(.success(results))
            } catch {
                print(#line, error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getActorInformation
    func getActorInformation(with personId: Int, completion: @escaping (Result<ActorInformation, Error>) -> Void) {
        
        guard let url = URL(string: Constants.actorInformation + "/\(personId)") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let results = try JSONDecoder().decode(ActorInformation.self, from: data)
                completion(.success(results))
            } catch {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getImages
    func getImages(with id: Int, completion: @escaping (Result<[VideoImages], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + "/\(id)/images?type=STILL&page=1") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(#line, String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Images.self, from: data)
                completion(.success(results.items))
            } catch {
                print(#line, error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    // MARK: - getReviews
    func getReviews(with id: Int, completion: @escaping (Result<[VideoReview], Error>) -> Void) {
        
        guard let url = URL(string: Constants.baseURL + "/\(id)/reviews?page=1&order=DATE_DESC") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(Constants.API_KEY, forHTTPHeaderField: "X-API-KEY")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let results = try JSONDecoder().decode(Reviews.self, from: data)
                completion(.success(results.items))
            } catch {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
