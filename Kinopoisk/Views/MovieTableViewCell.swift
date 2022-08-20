//
//  MovieTableViewCell.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 07.06.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Propeties
    private let playButton: UIButton = {
        
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let label: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        
        return label
    }()
    
    private let posterImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(label)
        contentView.addSubview(playButton)
        
        applyConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func applyConstrains() {
        
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        label.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -30).isActive = true
        
        playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    public func configure(with model: MovieViewModel) {
        
        guard let url = URL(string: String(model.posterURL)) else { return }
        
        posterImageView.sd_setImage(with: url)
        label.text = model.movieName
    }
}

