//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 7/6/23.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    // MARK: - Properties
    let identifier = "CharacterCell"
    
    private lazy var nameTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Name: "
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aViewBackground: UIView = {
       let aView = UIView()
        aView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        aView.layer.cornerRadius = 10
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private lazy var aCoverImage: UIImageView = {
       let aView = UIImageView()
        aView.layer.cornerRadius = 15
        aView.image = UIImage(systemName: "photo")
        aView.contentMode = .scaleAspectFit
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    // MARK: - SetupView
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(aCoverImage)
        addSubview(aViewBackground)
        aViewBackground.addSubview(nameTitle)
        aViewBackground.addSubview(nameValue)
        
        NSLayoutConstraint.activate([
            aCoverImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            aCoverImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            aCoverImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            aCoverImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            aViewBackground.leadingAnchor.constraint(equalTo: aCoverImage.leadingAnchor, constant: 10),
            aViewBackground.trailingAnchor.constraint(equalTo: aCoverImage.trailingAnchor, constant: -10),
            aViewBackground.bottomAnchor.constraint(equalTo: aCoverImage.bottomAnchor),
            aViewBackground.heightAnchor.constraint(equalToConstant: 60),
            
            nameTitle.topAnchor.constraint(equalTo: aViewBackground.topAnchor, constant: 8),
            nameTitle.leadingAnchor.constraint(equalTo: aViewBackground.leadingAnchor, constant: 8),
            
            nameValue.topAnchor.constraint(equalTo: aViewBackground.topAnchor, constant: 8),
            nameValue.leadingAnchor.constraint(equalTo: nameTitle.trailingAnchor, constant: 4),
            nameValue.trailingAnchor.constraint(equalTo: aViewBackground.trailingAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.aCoverImage.image = nil
    }
    
    // MARK: - Methods
    func configureCell(character: Results) {
        guard let url = URL(string: character.image) else { return }
        DispatchQueue.main.async {
            self.aCoverImage.loadImage(at: url)
            self.nameValue.text = character.name
        }
    }
    
}
