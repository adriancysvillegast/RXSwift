//
//  CollectionCell.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 6/6/23.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    // MARK: - Properties
    let identifierCell = "CollectionCell"
    
    private lazy var aCoverImage: UIImageView = {
        let aCover = UIImageView()
        aCover.backgroundColor = .red
        return aCover
    }()
    
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: .max))
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.textColor = .black
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            aCoverImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            aCoverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            aCoverImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            aCoverImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            
            nameLabel.centerXAnchor.constraint(equalTo: aCoverImage.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell() {
        self.nameLabel.text = "testing"
    }
}
