//
//  ActorViewController.swift
//  Kinopoisk
//
//  Created by Наталья Шарапова on 26.05.2022.
//

import UIKit
import SDWebImage

class ActorViewController: UIViewController {
    
    //MARK: - Properties
    
    private var films: [ActorsFilms] = []
    private var films1 = Set<String>()
    
    private let actorView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.orange.cgColor
        view.layer.shadowRadius = 5;
        view.layer.shadowOpacity = 1
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.backgroundColor = UIColor.black.cgColor
        
        return view
    }()
    
    private let tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ActorsFilmTableViewCell.self, forCellReuseIdentifier: Identifier.actorsFilmTableViewCell.rawValue)
        return tableView
    }()
    
    private let actorImageView = UIImageView(contentMode: .scaleAspectFill, cornerRadius: 8)
    private lazy var stackView = UIStackView(axis: .vertical, distribution: .fill, alignment: .center, spacing: 8)
    
    private let nameLabel = UILabel(textColor: .white, font: .boldSystemFont(ofSize: 30), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    private let professionLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 15), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    private let birthLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 15), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    private let ageLabel = UILabel(textColor: .white, font: .systemFont(ofSize: 15), cornerRadius: 0, numberOfLines: 0, textAlignment: .center)
    
    //MARK: - ViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        actorImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actorImageView.clipsToBounds = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.6
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupViews()
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        view.addSubview(actorView)
        
        actorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        actorView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        actorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        actorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        actorView.addSubview(actorImageView)
        
        actorImageView.leadingAnchor.constraint(equalTo: actorView.leadingAnchor).isActive = true
        actorImageView.heightAnchor.constraint(equalTo: actorView.heightAnchor).isActive = true
        actorImageView.topAnchor.constraint(equalTo: actorView.topAnchor).isActive = true
        actorImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        actorView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(professionLabel)
        stackView.addArrangedSubview(birthLabel)
        stackView.addArrangedSubview(ageLabel)
        
        stackView.leadingAnchor.constraint(equalTo: actorImageView.trailingAnchor, constant: 15).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.topAnchor.constraint(equalTo: actorView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: actorView.trailingAnchor).isActive = true
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.topAnchor.constraint(equalTo: actorView.bottomAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
    }
    
   public func configure(with actor: ActorInformation) {
        
        guard let urlString = actor.posterUrl else { return }
        let url = URL(string: urlString)
        actorImageView.sd_setImage(with: url)
        
        guard let name = actor.nameRu,
              let birth = actor.birthday,
              let age = actor.age,
              let profession = actor.profession  else { return }
        
        nameLabel.text = name
        birthLabel.text = birth
        ageLabel.text = String(age)
        professionLabel.text = profession
        
        self.films = actor.films
        
        for film in films {
            guard let name = film.nameRu else { return }
            films1.insert(name)
        }
    }
}
//MARK: - Extensions
//MARK: - UITableViewDelegate, UITableViewDataSource

extension ActorViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.actorsFilmTableViewCell.rawValue, for: indexPath)
        
        let name = films1.sorted()[indexPath.row]
        
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Лучшие фильмы и сериалы"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 200, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizedFithFirstLetter()
    }
}




