//
//  DataPersistenceManager.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 05.06.2022.
//

import Foundation
import UIKit
import CoreData

enum DataBaseError: Error {
    case failedToSaveData
    case failedToFetchData
}

class DataPersistenceManager {
    
    // MARK: - Properties
    static let shared = DataPersistenceManager()
    
    // MARK: - Methods
    
    // Download film to the DataBase
    func downloadItemFith(model: Item, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FilmItem", in: context)
        let item = FilmItem(entity: entity!, insertInto: context)
        
        item.duration = Int64(model.duration ?? 0)
        item.filmId = Int64(model.filmId ?? 0)
        item.filmLength = model.filmLength
        item.posterUrl = model.posterUrl
        item.imdbId = model.imdbId
        item.kinopoiskId = Int64(model.kinopoiskId ?? 0)
        item.nameEn = model.nameEn
        item.nameOriginal = model.nameOriginal
        item.nameRu = model.nameRu
        item.posterUrl = model.posterUrl
        item.posterUrlPreview = model.posterUrlPreview
        item.rating = model.rating
        item.ratingAgeLimits = model.ratingAgeLimits
        item.ratingFilmCritics = Int64(model.ratingFilmCritics ?? 0)
        item.ratingGoodReview = Int64(model.ratingGoodReview ?? 0)
        item.ratingImdb = model.ratingImdb ?? 0
        item.ratingImdbVoteCount = Int64(model.ratingImdbVoteCount ?? 0)
        item.ratingKinopoisk = model.ratingKinopoisk ?? 0
        item.ratingKinopoiskVoteCount = Int64(model.ratingKinopoiskVoteCount ?? 0)
        item.ratingVoteCount = Int64(model.ratingVoteCount ?? 0)
        item.releaseDate = model.releaseDate
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            
            print(String(describing: error))
            completion(.failure(DataBaseError.failedToSaveData))
        }
    }
    
    // Fetch film from the DataBase
    func fetchingMoviesFromDataBase(completion: @escaping(Result<[FilmItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<FilmItem>
        
        request = FilmItem.fetchRequest()
        
        do {
            let items = try context.fetch(request)
            completion(.success(items))
            
        } catch {
            completion(.failure(DataBaseError.failedToFetchData))
        }
    }
    
    // Delete film from the DataBase
    func deleteMovieFromDataBase(model: FilmItem, completion: @escaping(Result<Void, Error>) -> Void) {
        
        guard let appDelagate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelagate.persistentContainer.viewContext
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
            
        } catch {
            completion(.failure((error)))
        }
    }
}
