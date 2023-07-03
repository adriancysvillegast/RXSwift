//
//  SingleCharacterModel.swift
//  RickAndMorty
//
//  Created by Adriancys Jesus Villegas Toro on 11/6/23.
//

import Foundation

struct SingleCharacterModel: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: LocationCharacter
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct LocationCharacter: Codable {
    let name: String
    let url: String
}
