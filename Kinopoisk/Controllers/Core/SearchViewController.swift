//
//  SearchViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 06.05.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    enum Sections: Int {
        case Random = 0
        case Films2022 = 1
        case Serials2022 = 2
    }
    
    //MARK: - Properties
    
    private let searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PosterCollectionViewTableViewCell.self, forCellReuseIdentifier: Identifier.posterCollectionViewTableViewCell.rawValue)
        
        return tableView
    }()
    
    private let searchController: UISearchController = {
        
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Поиск по фильмам"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    let sectionTitles: [String] = ["Случайный выбор", "Фильмы 2022 года", "Сериалы 2022 года"]
    
    //MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchTableView)
        
        searchTableView.dataSource = self
        searchTableView.delegate = self
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchTableView.frame = view.bounds
    }
}

//MARK: - Extensions
//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.posterCollectionViewTableViewCell.rawValue, for: indexPath) as? PosterCollectionViewTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch indexPath.section {
        
        case Sections.Random.rawValue:
            
            APICaller.shared.getRandom { result in
                
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
            
        case Sections.Films2022.rawValue:
            
            APICaller.shared.getFilms2022 { result in
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
            
        case Sections.Serials2022.rawValue:
            APICaller.shared.getSerials2022 { result in
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 200, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizedFithFirstLetter()
    }
}

//MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2 else { return }
        
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        resultsController.delegate = self
        
        APICaller.shared.search(with: query) { result in
            
            DispatchQueue.main.async {
                switch result {
                
                case .success(let films):
                    resultsController.films = films
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        }
    }
}

//MARK: - CollectionViewTableViewCellDelegate

extension SearchViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewCellDidTapCell(_ cell: PosterCollectionViewTableViewCell, with item: Item) {
        
        guard let id = item.kinopoiskId ?? item.filmId ?? Int(item.imdbId ?? "") else { return }
        
        APICaller.shared.getSerialSeasonEpisode(with: id) { result in
            switch result {
            
            case .success(let serialResponse):
                
                DispatchQueue.main.async {
                    let vc = PreviewViewController()
                    vc.configure(with: item, serial: serialResponse)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    let vc = PreviewViewController()
                    vc.configure(with: item, serial: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

//MARK: - SearchResultsViewControllerDelegate

extension SearchViewController: SearchResultsViewControllerDelegate {
    
    func searchResultsViewControllerDidTapItem(with item: Item) {
        
        guard let id = item.kinopoiskId ?? item.filmId ?? Int(item.imdbId ?? "") else { return }
        
        APICaller.shared.getSerialSeasonEpisode(with: id) { result in
            
            switch result {
            
            case .success(let serialResponse):
                DispatchQueue.main.async {
                    let vc = PreviewViewController()
                    vc.configure(with: item, serial: serialResponse)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    let vc = PreviewViewController()
                    vc.configure(with: item, serial: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
