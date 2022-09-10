//
//  SearchResultsViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 10.05.2022.
//

import UIKit

// MARK: - Protocol

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(with item: Item)
}

class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    
    public var films = [Item]()
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier:Identifier.posterCollectionViewCell.rawValue)
        return collectionView
    }()
    
    // MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchResultsCollectionView.frame = view.bounds
    }
    // MARK: - Methods
    
    private func downloadItemAt(indexPath: IndexPath) {
        
        DataPersistenceManager.shared.downloadItemFith(model: films[indexPath.row]) { result in
            
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Extensions
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.posterCollectionViewCell.rawValue, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        guard let model = (films[indexPath.row].posterUrlPreview != nil) ? films[indexPath.row].posterUrlPreview : films[indexPath.row].posterUrl else { return UICollectionViewCell() }
        
        if let rating = films[indexPath.row].rating {
            
            cell.configure(with: model, ratingString: rating)
            
            return cell
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let item = films[indexPath.row]
        
        self.delegate?.searchResultsViewControllerDidTapItem(with: item)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil) { _ in
            let action = UIAction(title: "Download",
                                  image: UIImage(systemName: "arrow.down.to.line"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  state: .off) { _ in
                self.downloadItemAt(indexPath: indexPath)
            }
                                                    return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [action])
            
        }
        return config
    }
}

// MARK: - CollectionViewTableViewCellDelegate

extension SearchResultsViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewCellDidTapCell(_ cell: PosterCollectionViewTableViewCell, with item: Item) {
        
        guard let id = item.kinopoiskId ?? item.filmId ?? Int(item.imdbId ?? "") else { return }
        
        APICaller.shared.getSerialSeasonEpisode(with: id) { result in
            switch result {
            
            case .success(let serialResponse):
                
                DispatchQueue.main.async { [weak self] in
                    let vc = PreviewViewController()
                    vc.configure(with: item, serial: serialResponse)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    let vc = PreviewViewController()
                    vc.configure(with: item, serial: nil)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
