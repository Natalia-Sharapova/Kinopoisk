//
//  HomeViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 06.05.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum Sections: Int {
        case TopBestFilms = 0
        case TopPopularFilms = 1
        case RecomendedSeries = 2
        case Horrors = 3
        case Detectives = 4
    }
    
    //MARK: - Properties
    
    private var randomPopularMovie: Item?
    var headerView: HeaderView?
    
    private let homeTableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PosterCollectionViewTableViewCell.self, forCellReuseIdentifier: Identifier.posterCollectionViewTableViewCell.rawValue)
        return tableView
    }()
    
    let sectionTitles: [String] = ["ТОП-20 лучших фильмов", "ТОП-20 популярных фильмов", "Рекомендуемые сериалы", "Ужасы", "Детективы"]
    
    
    //MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        headerView?.delegate = self
        
        homeTableView.tableHeaderView = headerView
        
        configureNavBar()
        configureHeaderView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeTableView.frame = view.bounds
    }
    
    //MARK: - Methods
    private func configureHeaderView() {
        
        APICaller.shared.getPopularFilms { [weak self] result in
            switch result {
            case .success(let items):
                
                self?.randomPopularMovie = items.randomElement()
                
                guard let posterURL = self?.randomPopularMovie?.posterUrl ?? self?.randomPopularMovie?.posterUrlPreview else { return }
                
                self?.headerView?.configure(with: posterURL, randomPopularMovie: (self?.randomPopularMovie)!)
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func configureNavBar() {
        
        var image = UIImage(named: "kinopoisk")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
    }
}

//MARK: - Extensions
//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        case Sections.TopBestFilms.rawValue:
            APICaller.shared.getBestFilms { result in
                
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TopPopularFilms.rawValue:
            APICaller.shared.getPopularFilms { result in
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.RecomendedSeries.rawValue:
            APICaller.shared.getBestTvSeries { result in
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Horrors.rawValue:
            APICaller.shared.getHorrors { result in
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Detectives.rawValue:
            APICaller.shared.getDetectives { result in
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let defaultOffset = view.safeAreaInsets.top
        
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 200, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizedFithFirstLetter()
    }
}

//MARK: - CollectionViewTableViewCellDelegate
extension HomeViewController: CollectionViewTableViewCellDelegate {
    
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

//MARK: - PlayButtonTappedDelegate
extension HomeViewController: PlayButtonTappedDelegate {
    
    func playButtonTappedWithDelegate(with item: Item) {
        
        guard let nameMovie = item.nameEn ?? item.nameOriginal else { return }
        
        APICaller.shared.getTrailer(with: nameMovie) { result in
            
            switch result {
            case .success(let videoElement):
                
                DispatchQueue.main.async {
                    
                    let vc = TrailerViewController()
                    
                    vc.configure(with: nameMovie, youtubeVideo: videoElement)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Error", error.localizedDescription)
            }
            return
        }
    }
}
