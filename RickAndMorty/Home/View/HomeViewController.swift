//
//  HomeViewController.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 3/6/23.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    // MARK: - Properties
    private var characters: [Results] = []
    private var searchCharacters: [Results] = []
    private var disposeBag = DisposeBag()
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()

    private lazy var aTableView: UITableView = {
       let aTable = UITableView()
        aTable.rowHeight = 400
        aTable.backgroundColor = .black
        aTable.delegate = self
        aTable.dataSource = self
        aTable.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell().identifier)
        aTable.translatesAutoresizingMaskIntoConstraints =  false
        return aTable
    }()
    
    private lazy var searchBarCharacters: UISearchController = {
       let search = UISearchController(searchResultsController: nil)
        search.searchBar.barStyle = .black
        search.hidesNavigationBarDuringPresentation = true
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search a Character "
        search.searchBar.sizeToFit()
        search.delegate = self
        search.searchBar.backgroundColor = .clear
        return search
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Characters"
        viewModel.bind(view: self, router: router)
        setupView()
        setupConstraints()
        getCharacter()
        managerSearchBar()
    }
    

    // MARK: - SetupView
    private func setupView() {
        view.addSubview(aTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            aTableView.topAnchor.constraint(equalTo: view.topAnchor),
            aTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    // MARK: - Methods
    func updateView() {
        DispatchQueue.main.async {
            self.aTableView.reloadData()
        }
    }
    
    func getCharacter() {
        return viewModel.getCharacterData()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe { character in
                self.characters = character
                self.updateView()
            } onError: { e in
                print(e)
            } onCompleted: {
                
            }.disposed(by: disposeBag)
    }
    
    func managerSearchBar() {
        let searchBar = searchBarCharacters.searchBar
        aTableView.tableHeaderView = searchBar
        aTableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height)
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe { results in
                self.searchCharacters = self.characters.filter({ character in
                    self.updateView()
                    return character.name.contains(results.element ?? "")
                })
            }.disposed(by: disposeBag)
    }
    
}
// MARK: - UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarCharacters.isActive && searchBarCharacters.searchBar.text != "" {
            return searchCharacters.count
        }
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell().identifier, for: indexPath) as? CharacterCell else { return UITableViewCell() }
        if searchBarCharacters.isActive && searchBarCharacters.searchBar.text != "" {
            cell.configureCell(character: searchCharacters[indexPath.row])
        }else {
            cell.configureCell(character: characters[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBarCharacters.isActive && searchBarCharacters.searchBar.text != "" {
            viewModel.buildDetailView(id: searchCharacters[indexPath.row].id)
        }else {
            viewModel.buildDetailView(id: characters[indexPath.row].id)
        }
    }
}
// MARK: - UISearchControllerDelegate
extension HomeViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarCharacters.isActive = false
        updateView()
    }
}

