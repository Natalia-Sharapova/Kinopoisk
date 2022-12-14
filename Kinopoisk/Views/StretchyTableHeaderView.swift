//
//  PreviewHeaderView.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 11.05.2022.
//

import UIKit
import SDWebImage

// MARK: - Protocol

protocol PlayButtonTappedDelegate: AnyObject {
    func playButtonTappedWithDelegate(with item: Item)
}

final class StretchyTableHeaderView: UIView {
    
    // MARK: - Properties
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerViewHeight = NSLayoutConstraint()
    
    private var item: Item!
    weak var delegate: PlayButtonTappedDelegate?
    
    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    // Buttons
    private let downloadButton = UIButton(title: nil, cornerRadius: 20, backgroundColor: .systemGray, titleColor: .orange)
    private let playButton = UIButton(title: "▷ Смотреть", cornerRadius: 18, backgroundColor: .orange, titleColor: .black)
    
    // Labels
    public let nameLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 30), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    public let ratingLabel = UILabel(textColor: .systemRed, font: .systemFont(ofSize: 14), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    public let originalNameLabel = UILabel(textColor: .systemGray, font: .systemFont(ofSize: 14), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    public let genreLabel = UILabel(textColor: .systemGray, font: .systemFont(ofSize: 12), cornerRadius: 0, numberOfLines: 0, textAlignment: .right)
    public let seasonsLabel = UILabel(textColor: .systemGray, font: .systemFont(ofSize: 12), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    public let countryLabel = UILabel(textColor: .systemGray, font: .systemFont(ofSize: 12), cornerRadius: 0, numberOfLines: 0, textAlignment: .right)
    public let filmLengthLabel = UILabel(textColor: .systemGray, font: UIFont.systemFont(ofSize: 12), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    public let ageLabel = UILabel(textColor: .systemGray, font: UIFont.systemFont(ofSize: 12), cornerRadius: 0, numberOfLines: 0, textAlignment: .left)
    
    // StackViews
    public let buttonsStackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 20)
    public let countryStackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5)
    public let ratingStackView = UIStackView(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 5)
    public let genreStackView = UIStackView(axis: .horizontal, distribution: .fillEqually, alignment: .center, spacing: 5)
    
    // ImageView
    public let heroImageView = UIImageView(contentMode: .scaleAspectFill, cornerRadius: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setItems()
        
        addSubview(containerView)
        containerView.addSubview(heroImageView)
        addGradient()
        addSubview(nameLabel)
        addSubview(ratingStackView)
        addSubview(genreStackView)
        addSubview(countryStackView)
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(downloadButton)
        ratingStackView.addArrangedSubview(originalNameLabel)
        ratingStackView.addArrangedSubview(ratingLabel)
        genreStackView.addArrangedSubview(genreLabel)
        genreStackView.addArrangedSubview(seasonsLabel)
        countryStackView.addArrangedSubview(countryLabel)
        countryStackView.addArrangedSubview(ageLabel)
        countryStackView.addArrangedSubview(filmLengthLabel)
        
        setViewConstraints()
        configureDownloadButton()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Deleted"), object: nil, queue: nil) { [weak self] _ in
            self?.downloadButton.backgroundColor = .systemGray
        }
        
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Methods
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func configureDownloadButton() {
        
        var image = UIImage(named: "save")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        downloadButton.setImage(image, for: .normal)
    }
    
    @objc func downloadButtonTapped() {
        
        // Download the item to the DataBase
        DataPersistenceManager.shared.downloadItemFith(model: item) { result in
            
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        downloadButton.backgroundColor = .systemGreen
    }
    
    // Open the Trailer VC
    @objc func playButtonTapped() {
        self.delegate?.playButtonTappedWithDelegate(with: item)
    }
    
   private func setViewConstraints() {
    
    NSLayoutConstraint.activate([
        
        // nameLabel Constraints
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        
        // StackView Constraints
        ratingStackView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
        ratingStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ratingStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 600),
        ratingStackView.heightAnchor.constraint(equalToConstant: 25),
        
        genreStackView.bottomAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 20),
        genreStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        genreStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 600),
        genreStackView.heightAnchor.constraint(equalToConstant: 25),
        
        countryStackView.bottomAnchor.constraint(equalTo: genreStackView.bottomAnchor, constant: 20),
        countryStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        countryStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 600),
        countryStackView.heightAnchor.constraint(equalToConstant: 25),
        
        buttonsStackView.topAnchor.constraint(equalTo: countryStackView.bottomAnchor, constant: 15),
        buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        buttonsStackView.widthAnchor.constraint(lessThanOrEqualToConstant: 450),
        buttonsStackView.heightAnchor.constraint(equalToConstant: 42),
    
        // Buttons Constraints
        playButton.widthAnchor.constraint(equalToConstant: 160),
        playButton.heightAnchor.constraint(equalToConstant: 40),
        
        downloadButton.widthAnchor.constraint(equalToConstant: 40),
        downloadButton.heightAnchor.constraint(equalToConstant: 40),
        
        // Container View Constraints
        containerView.widthAnchor.constraint(equalTo: heroImageView.widthAnchor),
        
        self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
        self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
    ])
   
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
    containerViewHeight.isActive = true
        
        // ImageView Constraints
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = heroImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = heroImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
   private func setItems() {
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = true
        
        originalNameLabel.translatesAutoresizingMaskIntoConstraints = true
        originalNameLabel.translatesAutoresizingMaskIntoConstraints = true
        seasonsLabel.translatesAutoresizingMaskIntoConstraints = true
        
        countryLabel.translatesAutoresizingMaskIntoConstraints = true
        filmLengthLabel.translatesAutoresizingMaskIntoConstraints = true
        filmLengthLabel.sizeToFit()
        ageLabel.translatesAutoresizingMaskIntoConstraints = true
        heroImageView.clipsToBounds = true
        
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        countryStackView.translatesAutoresizingMaskIntoConstraints = false
        
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        genreStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configure(with item: Item, serial: SerialResponse?) {
        
        self.item = item
        
        guard let url = item.posterUrl ?? item.posterUrlPreview else { return }
        guard let posterURL = URL(string: url) else { return }
        guard let name = item.nameRu ?? item.nameOriginal,
              let genres = item.genres,
              let countries = item.countries else { return }
        
        if let filmLenth = item.filmLength {
            filmLengthLabel.text = String(filmLenth) + " мин"
        } else {
            filmLengthLabel.text = "-"
        }
        
        // MARK: - Set the seasons depends on URL response
        
        if let seasons = serial?.total {
            switch seasons {
            case 0:
                seasonsLabel.text = "-"
            case 1, 21, 31:
                seasonsLabel.text = String(seasons) + " сезон"
            case 2, 3, 4, 22, 23, 24, 32:
                seasonsLabel.text = String(seasons) + " сезона"
            default:
                seasonsLabel.text = String(seasons) + " сезонов"
            }
        } else {
            seasonsLabel.text = nil
        }
        
        // MARK: - Set the rating depends on URL response
        
        if let rating = item.ratingKinopoisk {
            ratingLabel.text = String(format: "%.1f", rating) + ","
            if rating < 7 {
                ratingLabel.textColor = .systemGray
            } else {
                ratingLabel.textColor = .systemGreen
            }
            
        } else if let rating = item.ratingImdb {
            
            ratingLabel.text = String(format: "%.1f", rating) + ","
            if rating < 7 {
                ratingLabel.textColor = .systemGray
            } else {
                ratingLabel.textColor = .systemGreen
            }
            
        } else if let rating = item.rating {
            
            if let ratingDouble = Double(rating) {
                
                if ratingDouble < 7 {
                    ratingLabel.textColor = .systemGray
                } else if ratingDouble > 7 {
                    ratingLabel.textColor = .systemGreen
                }
                ratingLabel.text = rating + ","
                
            } else {
                ratingLabel.text = "Рейтинг: скоро" + ","
            }
        }
        
        // MARK: - Set the genres depends on URL response
        
        switch genres.count {
        case 1:
            let genre1 = genres[0].genre
            genreLabel.text = genre1
        case 2:
            let genre1 = genres[0].genre.capitalizedFithFirstLetter()
            let genre2 = genres[1].genre.capitalizedFithFirstLetter()
            genreLabel.text = genre1 + ", " + genre2 + ","
            
        case 3:
            let genre1 = genres[0].genre.capitalizedFithFirstLetter()
            let genre2 = genres[1].genre.capitalizedFithFirstLetter()
            let genre3 = genres[2].genre.capitalizedFithFirstLetter()
            genreLabel.text = genre1 + ", " + genre2 + ", " + genre3 + ","
            
        case 4:
            let genre1 = genres[0].genre.capitalizedFithFirstLetter()
            let genre2 = genres[1].genre.capitalizedFithFirstLetter()
            let genre3 = genres[2].genre.capitalizedFithFirstLetter()
            let genre4 = genres[3].genre.capitalizedFithFirstLetter()
            genreLabel.text = genre1 + ", " + genre2 + ", " + genre3 + ", " + genre4 + ","
            
        default:
            let genre1 = genres[0].genre.capitalizedFithFirstLetter()
            genreLabel.text = genre1 + ","
        }
        
        // MARK: - Set the countries depends on URL response
        switch countries.count {
        case 1:
            let country1 = countries[0].country
            countryLabel.text = country1 + ","
        case 2:
            let country1 = countries[0].country
            let country2 = countries[1].country
            countryLabel.text = country1 + ", " + country2 + ","
        default:
            let country1 = countries[0].country
            countryLabel.text = country1 + ","
        }
        
        heroImageView.sd_setImage(with: posterURL, completed: nil)
        nameLabel.text = name
        originalNameLabel.text = name
        
        if let age = item.ratingAgeLimits {
            ageLabel.text = age
        } else {
            ageLabel.text = "Нет данных о возрасте,"
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}

