//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 11/6/23.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    // MARK: - Properties
    
    
    private var router = DetailRouter()
    private var detailViewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    var idCharacter: Int?
    
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

    private lazy var aCoverImage: UIImageView = {
       let aView = UIImageView()
        aView.layer.cornerRadius = 15
        aView.image = UIImage(systemName: "photo")
        aView.contentMode = .scaleAspectFit
        aView.backgroundColor = .red
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.bind(view: self, router: router)
        getCharacter()
        setupView()
        setupConstraints()
    }
    
    // MARK: - SetupView
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(aCoverImage)
        [nameTitle, nameValue].forEach { aCoverImage.addSubview($0)}
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            aCoverImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            aCoverImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            aCoverImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            aCoverImage.heightAnchor.constraint(equalToConstant: 400),
            
            nameTitle.topAnchor.constraint(equalTo: aCoverImage.bottomAnchor, constant: 10),
            nameTitle.leadingAnchor.constraint(equalTo: aCoverImage.leadingAnchor),
            
            nameValue.topAnchor.constraint(equalTo: aCoverImage.bottomAnchor, constant: 10),
            nameValue.leadingAnchor.constraint(equalTo: nameTitle.trailingAnchor, constant: 4)
            
        ])
    }
    // MARK: - Methods

    func getCharacter() {
        guard let id = idCharacter else { return }
        
        detailViewModel.getdetailCharacter(id: id).subscribe { detail in
            self.showData(data: detail)
        } onError: { e in
            print(e)
        } onCompleted: {
        }.disposed(by: disposeBag)
    }
    
    private func showData(data: SingleCharacterModel) {
        guard let url = URL(string: data.image) else { return }
        DispatchQueue.main.async {
            self.aCoverImage.loadImage(at: url)
            self.nameValue.text = data.name
        }
    }
}
