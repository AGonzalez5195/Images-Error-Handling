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
    
    
    static func getPokemonCardData(completionHandler: @escaping (Result<[Card],AppError>) -> () ) {
        let url = "https://api.pokemontcg.io/v1/cards?contains=types"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let pokemonData = try JSONDecoder().decode(Pokemon.self, from: data)
                    completionHandler(.success(pokemonData.cards))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
    
    
//    static func getPokemon(from data: Data) throws -> [Card] {
//        do {
//            let PokemonData = try JSONDecoder().decode(Pokemon.self, from: data)
//            return PokemonData.cards
//        } catch {
//            throw JSONError.decodingError(error)
//        }
//    }
}

struct Card: Codable {
    let name: String
    //    let nationalPokedexNumber: Int?
    let imageURLHiRes: String
    let weaknesses: [Weakness]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURLHiRes = "imageUrlHiRes"
        case weaknesses
    }
}

struct Weakness: Codable {
    let type: String
}
