//
//  xkcdAPIHelper.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation

class xkcdAPIHelper{
    private init () {}
    
    static let shared = xkcdAPIHelper()
    
    
    func getPokemonCards(completionHandler: @escaping (Result<xkcdComic, Error>) -> Void){
        
        let urlStr = "https://xkcd.com/1/info.0.json"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(ErrorHandling.badURL))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(ErrorHandling.noData))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(ErrorHandling.noData))
                return
            }
            
            do {
                let xkcdData = try JSONDecoder().decode(xkcdComic.self, from: data)
                
                completionHandler(.success(xkcdData))
            }
            catch {
                completionHandler(.failure(ErrorHandling.decodingError))
            }
            
            }.resume()
        
    }
    
}
