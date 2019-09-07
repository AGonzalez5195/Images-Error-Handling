//
//  PokemonAPIHelper.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation

//class PokemonAPIHelper{
//    private init () {}
//
//    static let shared = PokemonAPIHelper()
//
//
//    func getPokemonCards(completionHandler: @escaping (Result<[Pokemon], Error>) -> Void){
//
//        let urlStr = "https://api.pokemontcg.io/v1/cards"
//
//        guard let url = URL(string: urlStr) else {
//            completionHandler(.failure(ErrorHandling.badURL))
//            return
//        }
//
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard error == nil else {
//                completionHandler(.failure(ErrorHandling.noData))
//                return
//            }
//
//            guard let data = data else {
//                completionHandler(.failure(ErrorHandling.noData))
//                return
//            }
//
//            do {
//                let pokemonCardData = try JSONDecoder().decode([Pokemon].self, from: data)
//                
//                completionHandler(.success(pokemonCardData))
//            }
//            catch {
//                completionHandler(.failure(ErrorHandling.decodingError))
//            }
//
//
//
//            }.resume()
//
//
//    }
//
//
//}


struct PokemonAPI {
    
    static let shared = PokemonAPI()
    
    enum FetchPokemonErrors: Error {
        case remoteResponseError
        case noDataError
        case badDecodeError
        case badURLError
        case badHttpResponseCode
    }
    
    func fetchDataForAnyURL(url: String, completionHandler: @escaping (Result<Data,Error>) -> () ) {
        
        guard let url = URL(string: url) else {completionHandler(.failure(FetchPokemonErrors.badURLError))
            return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {completionHandler(.failure(FetchPokemonErrors.remoteResponseError))
                return
            }
            
            guard let data = data else {completionHandler(.failure(FetchPokemonErrors.noDataError))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {completionHandler(.failure(FetchPokemonErrors.badDecodeError))
                return
            }
            
            switch urlResponse.statusCode {
            case 200...299:
                completionHandler(.success(data))
            default:
                completionHandler(.failure(FetchPokemonErrors.badHttpResponseCode))
            }
            }.resume()
    }
}
