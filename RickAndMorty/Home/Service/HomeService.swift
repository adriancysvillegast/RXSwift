//
//  HomeService.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 7/6/23.
//

import Foundation
import RxSwift

class HomeService {
    
    private var characterURL = ProcessInfo.processInfo.environment["characterURL"] ?? "https://rickandmortyapi.com/api/character"
    
    func getCharacter() -> Observable<[Results]> {
        return Observable.create { [self] observer in
            
            let url = URL(string: characterURL)!
            
            let session = URLSession.shared
            session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    observer.onError(error!)
                }
                
                if let safeData = data {
                    do{
                        let decoder = JSONDecoder()
                        let character = try decoder.decode(CharacterModel.self, from: safeData)
                        observer.onNext(character.results)
                    }catch let e {
                        observer.onError(e)
                    }
                }
                observer.onCompleted()
            }.resume()
            
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
        
    }
    
}
