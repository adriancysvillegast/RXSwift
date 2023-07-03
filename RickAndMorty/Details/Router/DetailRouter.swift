//
//  DetailRouter.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 11/6/23.
//

import Foundation
import UIKit

class DetailRouter {
    // MARK: - Properties
    var viewController: UIViewController {
        return createViewController()
    }
    
    var idCharacter: Int?
    private var sourceView: UIViewController?
    
    init(idCharac: Int? = 0) {
        self.idCharacter = idCharac
    }
    
    // MARK: - Methods
    func setupSource(_ source: UIViewController?) {
        guard let view = source else { return }
        return self.sourceView = view
    }
    
    func createViewController() -> UIViewController {
        let vc = DetailViewController()
        vc.idCharacter = self.idCharacter
        return vc
    }
}
