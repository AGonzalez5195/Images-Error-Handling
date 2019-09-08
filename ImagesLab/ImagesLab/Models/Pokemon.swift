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
}

struct Card: Codable {
    let name: String
    let types: [String]
    let imageURLHiRes: String
    let weaknesses: [Weakness]?
    let set: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURLHiRes = "imageUrlHiRes"
        case weaknesses
        case set
        case types
    }
    
    static func getSortedArray(arr: [Card]) -> [Card] {
        let sortedArr = arr.sorted{$0.name < $1.name}
        return sortedArr
    }
  
    
    func displayPokemonWeakness(card: Card) -> String {
        return "Weakness: \(card.weaknesses?[0].type ?? "None")"
    }
    
    static func getFilteredCards(arr: [Card], searchString: String) -> [Card] {
        return arr.filter{$0.name.lowercased().contains(searchString.lowercased())}
    }
}


struct Weakness: Codable {
    var type: String
}



