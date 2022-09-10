//
//  DownloadsViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 06.05.2022.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var items = [FilmItem]()
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Identifier.movieTableViewCell.rawValue)
        return tableView
    }()
    
    //MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Fetch the data from database
        fetchLocalStorageFromDownload()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageFromDownload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    //MARK: - Methods
    
    private func fetchLocalStorageFromDownload() {
        
        DataPersistenceManager.shared.fetchingMoviesFromDataBase { [weak self] result in
            switch result {
            
            case .success(let items):
                self?.items = items
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: - Extensions
//MARK: - UITableViewDelegate, UITableViewDataSource

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.movieTableViewCell.rawValue, for: indexPath) as? MovieTableViewCell else { return UITableViewCell () }
        
        let item = items[indexPath.row]
        
        let movieName = item.nameRu ?? item.nameOriginal ?? "Unknown name"
        let posterURL = item.posterUrl ?? ""
        
        cell.configure(with: movieName, posterURL: posterURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            let movie = items[indexPath.row]
            
            DataPersistenceManager.shared.deleteMovieFromDataBase(model: movie) { result in
                
                switch result {
                case .success(()):
                    print("deleted from the dataBase")
                    
                case .failure((let error)):
                    print(String(describing: error))
                }
                self.items.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
                NotificationCenter.default.post(name: NSNotification.Name("Deleted"), object: nil)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = items[indexPath.row]
        
        guard let nameMovie = movie.nameEn ?? movie.nameOriginal else { return }
        
        APICaller.shared.getTrailer(with: nameMovie) { result in
            
            switch result {
            case .success(let videoElement):
                
                DispatchQueue.main.async { [weak self] in
                    let vc = TrailerViewController()
                    
                    vc.configure(with: nameMovie, youtubeVideo: videoElement)
                    
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Error", error.localizedDescription)
            }
            return
        }
    }
}

