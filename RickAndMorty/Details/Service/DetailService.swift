//
//  DetailService.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 11/6/23.
//

import Foundation
import RxSwift

class DetailService {
    // MARK: - Properties
    private let urlBase = ProcessInfo.processInfo.environment["characterInfo"] ?? "https://rickandmortyapi.com/api/character/"
    
    // MARK: - Methods
    func getDetail(idCharacter: Int) -> Observable<SingleCharacterModel> {
        return Observable.create { [self] observable in
            let url = URL(string: "\(urlBase)\(idCharacter)")!
            let session = URLSession.shared
            session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    observable.onError(error!)
                }
                
                if let safeData = data {
                    do{
                        let decoder = JSONDecoder()
                        let detail = try decoder.decode(SingleCharacterModel.self, from: safeData)
                        observable.onNext(detail)
                    }catch let e{
                        observable.onError(e)
                    }
                }
                observable.onCompleted()
            }.resume()
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
        
    }
}
