//
//  APICaller.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 07.05.2022.
//

import Foundation

enum APIError: Error {
    case failedToGetData
}

final class APICaller {
    
    // MARK: - Properties
    static let shared = APICaller()
    
    private init() {}
    
    // MARK: - Methods
    // MARK: - getAwaitFilms
    
   public func getAwaitFilms(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
   public func getBestFilms(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getBestTvSeries(completion: @escaping(Result<[Item], Error>) -> Void) {
        
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
    public func getHorrors(completion: @escaping(Result<[Item], Error>) -> Void) {
        
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
    public func getDetectives(completion: @escaping(Result<[Item], Error>) -> Void) {
        
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
    public func getPremiers(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getPopularFilms(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getTvShow(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getRandom(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getFilms2022(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getSerials2022(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getTurkishSerials(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getKoreanSerials(completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func search(with query: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        
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
    public func getTrailer(with query: String, completion: @escaping (Result<VideoElements, Error>) -> Void) {
        
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
    public func getSerialSeasonEpisode(with id: Int, completion: @escaping (Result<SerialResponse, Error>) -> Void) {
        
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
    public func getVideo(with id: Int, completion: @escaping (Result<[VideoKinopoisk], Error>) -> Void) {
        
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
    public func getActors(with id: Int, completion: @escaping (Result<[Actors], Error>) -> Void) {
        
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
    public func getActorInformation(with personId: Int, completion: @escaping (Result<ActorInformation, Error>) -> Void) {
        
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
    public func getImages(with id: Int, completion: @escaping (Result<[VideoImages], Error>) -> Void) {
        
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
    public func getReviews(with id: Int, completion: @escaping (Result<[VideoReview], Error>) -> Void) {
        
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
