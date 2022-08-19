//
//  PreviewViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 11.05.2022.
//

import UIKit

class PreviewViewController: UIViewController {
    
    enum Sections: Int {
        
        case RatingKinopoisk = 0
        case Trailers = 1
        case Actors = 2
        case Images = 3
        case Reviews = 4
    }
  
    private var item: Item!
    var headerView: StretchyTableHeaderView?
    var rowisHidden = false

    private let previewTableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(RatingKinipoiskTableViewCell.self, forCellReuseIdentifier: RatingKinipoiskTableViewCell.identifier)
        tableView.register(TrailerCollectionViewTableViewCell.self, forCellReuseIdentifier: TrailerCollectionViewTableViewCell.identifier)
        tableView.register(ActorCollectionViewTableViewCell.self, forCellReuseIdentifier: ActorCollectionViewTableViewCell.identifier)
        tableView.register(ImageCollectionViewTableViewCell.self, forCellReuseIdentifier: ImageCollectionViewTableViewCell.identifier)
        tableView.register(ReviewCollectionViewTableViewCell.self, forCellReuseIdentifier: ReviewCollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    let sectionTitles: [String] = ["Рейтинг Кинопоиска", "Трейлеры и тизеры", "Актеры", "Изображения", "Рецензии"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(previewTableView)
        previewTableView.delegate = self
        previewTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewTableView.frame = view.bounds
        navigationController?.navigationBar.transform = .init(translationX: 0, y: 0)
    }
   
   func configure(with item: Item, serial: SerialResponse?) {
    
        self.item = item
       
        configureHeaderView(with: item, serial: serial)
    }
   
 func configureHeaderView(with item: Item, serial: SerialResponse?) {
      
        headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        previewTableView.tableHeaderView = headerView
    
    headerView?.delegate = self
        
        headerView?.configure(with: item, serial: serial)
    }
}

extension PreviewViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let headerView = self.previewTableView.tableHeaderView as! StretchyTableHeaderView
                headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}

extension PreviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell: UITableViewCell = UITableViewCell()
        
        switch indexPath.section {
        
        case Sections.RatingKinopoisk.rawValue:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingKinipoiskTableViewCell.identifier, for: indexPath) as? RatingKinipoiskTableViewCell else { return UITableViewCell() }
            
            if let ratingDouble = item.ratingKinopoisk {
               
              let rating = String(format: "%.1f", ratingDouble)
                cell.configureRating(with: rating)
                
            } else if let ratingDouble = item.ratingImdb {
                let rating = String(format: "%.1f", ratingDouble)
                cell.configureRating(with: rating)
                
            } else if let rating = item.rating {
                cell.configureRating(with: rating)
            } else {
                cell.configureRating(with: "0.0")
            }
          
                if let ratingCount = item.ratingImdbVoteCount {
                cell.configureRatingCount(with: ratingCount)
            } else if let ratingCount = item.ratingKinopoiskVoteCount {
                cell.configureRatingCount(with: ratingCount)
            } else if let ratingCount = item.ratingVoteCount {
                cell.configureRatingCount(with: ratingCount)
            } else {
                cell.configureRatingCount(with: 0)
            }
            return cell
      
        case Sections.Trailers.rawValue:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TrailerCollectionViewTableViewCell.identifier, for: indexPath) as? TrailerCollectionViewTableViewCell else { return UITableViewCell() }
           
            guard let id = item.kinopoiskId ?? item.filmId ?? Int(item.imdbId ?? "") else { return UITableViewCell() }
            
            APICaller.shared.getVideo(with: id) { result in
                
                switch result {
                case .success(let videos):
                    cell.configure(with: videos)
                    print(#line,videos)
                    if videos.count == 0 {
                        self.rowisHidden = true
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
            return cell
            
        case Sections.Actors.rawValue:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActorCollectionViewTableViewCell.identifier, for: indexPath) as? ActorCollectionViewTableViewCell else { return UITableViewCell() }
           
            cell.delegate = self
            
            guard let id = item.kinopoiskId ?? item.filmId ?? Int(item.imdbId ?? "") else { return UITableViewCell() }
            
            APICaller.shared.getActors(with: id) { result in
                switch result {
                case .success(let actors):
                    cell.configure(with: actors)
                    
                case .failure(let error):
                    print(String(describing: error))
                }
            }
            return cell
            
        case Sections.Images.rawValue:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCollectionViewTableViewCell.identifier, for: indexPath) as? ImageCollectionViewTableViewCell else { return UITableViewCell() }
           
            guard let id = item.kinopoiskId ?? item.filmId ?? Int(item.imdbId ?? "") else { return UITableViewCell() }
          
            APICaller.shared.getImages(with: id) { result in
                switch result {
                case .success(let images):
                    cell.configure(with: images)
                    if images.count == 0 {
                        self.rowisHidden = true
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
            return cell
         
        case Sections.Reviews.rawValue:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCollectionViewTableViewCell.identifier, for: indexPath) as? ReviewCollectionViewTableViewCell else { return UITableViewCell() }
           
            cell.delegate = self
            guard let id = item.kinopoiskId ?? item.filmId ?? Int(item.imdbId ?? "") else { return UITableViewCell() }
        
            APICaller.shared.getReviews(with: id) { result in
                switch result {
                case .success(let reviews):
                    cell.configure(with: reviews)
                  if reviews.count == 0 {
                    self.rowisHidden = true
                    }
                case .failure(let error):
                    print(#line, String(describing: error))
                }
            }
            return cell
        default:
            break
        }
     return cell
    }
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        
        case Sections.RatingKinopoisk.rawValue:
            return 150
        case Sections.Trailers.rawValue:
            var height: CGFloat = 0.0
            if rowisHidden {
                height = 0
            } else {
                height = 250
            }
            return height
        case Sections.Actors.rawValue:
            return 320
       case Sections.Images.rawValue:
        var height: CGFloat = 0.0
    
        if rowisHidden {
            height = 0
        } else {
            height = 200
        }
        return height
     
     case Sections.Reviews.rawValue:
        var height: CGFloat = 0.0
    
        if rowisHidden {
            height = 0
        } else {
            height = 250
        }
       
        return height
        
     default:
        return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 200, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizedFithFirstLetter()
    }
}
extension PreviewViewController: ReviewCollectionViewTableViewCellDelegate {
    
    func collectionViewCellDidTapCell(_ cell: ReviewCollectionViewTableViewCell, with review: VideoReview) {
      
                    let vc = ReviewViewController()
                    vc.modalTransitionStyle = .flipHorizontal
                    vc.modalPresentationStyle = .popover
                    vc.configure(with: review)
                    
                    present(vc, animated: true, completion: nil)
    }
}
    
extension PreviewViewController: ActorCollectionViewTableViewCellDelegate {
    
    func actorCollectionViewCellDidTapCell(_ cell: ActorCollectionViewTableViewCell, with personId: Int) {
        
            APICaller.shared.getActorInformation(with: personId) { result in
                
                switch result {
                case .success(let actor):
                    DispatchQueue.main.async {
                        let vc = ActorViewController()
                        vc.configure(with: actor)
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
                }
    }
}

extension PreviewViewController: PlayButtonTappedDelegate {
    
    func playButtonTappedWithDelegate(with item: Item) {
        
        guard let nameMovie = item.nameEn ?? item.nameOriginal else { return }
        
        APICaller.shared.getTrailer(with: nameMovie) { result in
        
            switch result {
            case .success(let videoElement):
                
                DispatchQueue.main.async {
                let vc = TrailerViewController()
                
                vc.configure(with: TrailerViewModel(movieName: nameMovie, youtubeVideo: videoElement))
                
                self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                    print(#line, "Error", error.localizedDescription)
                }
                return
            }
    }
}
