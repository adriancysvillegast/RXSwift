//
//  HomeRouter.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 3/6/23.
//

import Foundation
import UIKit

class HomeRouter {
    
    // MARK: - Properties
    var viewController: UIViewController {
        return createViewController()
    }
    private var source: UIViewController?
    
    // MARK: - Methods
    func createViewController() -> UIViewController {
        return HomeViewController()
    }
    
    func setSource(_ source: UIViewController?) {
        guard let view = source else {
//            fatalError(" Error in function \(#function)")
            return
        }
        self.source = view
    }
    
    // MARK: - Navigation
    func navigationDetail(id: Int) {
        let detail = DetailRouter(idCharac: id).viewController
        source?.navigationController?.pushViewController(detail, animated: true)
    }
}
