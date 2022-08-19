//
//  HeaderView.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 06.05.2022.
//

import UIKit
import SDWebImage

class HeaderView: UIView {
    
    // MARK: - Properties
    private var item: Item!
    
    weak var delegate: PlayButtonTappedDelegate?
    
    private let heroImageView = UIImageView(contentMode: .scaleAspectFill, cornerRadius: 0)
    private let downloadButton = UIButton(title: nil, cornerRadius: 20, backgroundColor: .systemGray, titleColor: .orange)
    private let playButton = UIButton(title: "▷ Смотреть", cornerRadius: 18, backgroundColor: .orange, titleColor: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heroImageView.clipsToBounds = true
        downloadButton.setImage(UIImage(named: "save"), for: .normal)
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstrains()
        
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Deleted"), object: nil, queue: nil) { [weak self] _ in
            self?.downloadButton.backgroundColor = .systemGray
        }
    }
    
    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func applyConstrains() {
        
        playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90).isActive = true
        playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -110).isActive = true
        downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
        downloadButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        downloadButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    public func configure(with posterURL: String, randomPopularMovie: Item) {
        
        self.item = randomPopularMovie
        
        guard let url = URL(string: posterURL) else { return }
        heroImageView.sd_setImage(with: url, completed: nil)
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
}
