//
//  DetailViewModel.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 11/6/23.
//

import Foundation
import RxSwift

class DetailViewModel {
    // MARK: - Properties
    
    private var router: DetailRouter?
    private weak var view: DetailViewController?
    private var service = DetailService()
    
    // MARK: - Methods
    
    func bind(view: DetailViewController, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setupSource(view)
    }
    
    func getdetailCharacter(id: Int) -> Observable<SingleCharacterModel> {
//        print("Valor en \(#function) the id is \(id)")
        return service.getDetail(idCharacter: id)
    }
}
