//
//  Pokemon.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation


enum JSONError: Error {
    case decodingError(Error)
}

struct Pokemon: Codable {
    let cards: [Card]
    
    static func getPokemon(from data: Data) throws -> [Card] {
        do {
            let PokemonData = try JSONDecoder().decode(Pokemon.self, from: data)
            return PokemonData.cards
        } catch {
            throw JSONError.decodingError(error)
        }
    }
}

struct Card: Codable {
    let name: String
    //    let nationalPokedexNumber: Int?
    let imageURLHiRes: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURLHiRes = "imageUrlHiRes"
    }
}
