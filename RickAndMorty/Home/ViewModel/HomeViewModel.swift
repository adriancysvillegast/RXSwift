//
//  HomeViewModel.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 7/6/23.
//

import Foundation
import RxSwift

class HomeViewModel {
    // MARK: - properties
    
    private weak var view : HomeViewController?
    private var router: HomeRouter?
    private var service = HomeService()
    
    func bind(view: HomeViewController, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSource(view)
    }
    
    // MARK: - Methods
    
    func getCharacterData() -> Observable<[Results]> {
        return service.getCharacter()
    }
    
    func buildDetailView(id: Int) {
        router?.navigationDetail(id: id)
    }
    
}
