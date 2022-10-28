//
//  UpcomingViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 06.05.2022.
//

import UIKit

private enum Sections: Int {
    
    case Premiers = 0
    case AwaitFilms = 1
    case TvShow = 2
    case TurkishSerials = 3
    case KoreanSerials = 4
    
}

final class MediaViewController: UIViewController {
    
    //MARK: - Properties
    
    private let mediaTableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PosterCollectionViewTableViewCell.self, forCellReuseIdentifier: Identifier.posterCollectionViewTableViewCell.rawValue)
        return tableView
    }()
    
    private let sectionTitles: [String] = ["Кинопремьеры", "Скоро", "Тв-шоу", "Турецкие сериалы", "Корейские сериалы"]
    
    //MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mediaTableView)
        
        mediaTableView.dataSource = self
        mediaTableView.delegate = self
        
        title = "Медиа"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        mediaTableView.frame = view.bounds
    }
}

//MARK: - Extensions
//MARK: - UITableViewDelegate, UITableViewDataSource

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.posterCollectionViewTableViewCell.rawValue, for: indexPath) as? PosterCollectionViewTableViewCell  else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch indexPath.section {
        
        case Sections.Premiers.rawValue:
            
            APICaller.shared.getPremiers { result in
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TvShow.rawValue:
            
            APICaller.shared.getTvShow { result in
                
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TurkishSerials.rawValue:
            APICaller.shared.getTurkishSerials { result in
                
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.KoreanSerials.rawValue:
            APICaller.shared.getKoreanSerials { result in
                
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.AwaitFilms.rawValue:
            
            APICaller.shared.getAwaitFilms { result in
                switch result {
                case .success(let items):
                    cell.configureItems(with: items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        default:
            break
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
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

//MARK: - CollectionViewTableViewCellDelegate

extension MediaViewController: CollectionViewTableViewCellDelegate {
    
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
