//
//  xkcd.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation

struct xkcdComic: Codable {
    let img: String
    let safe_title: String
    let num: Int
    
    init() { //Required so that the code can compile without the "cannot invoke initializer with no arguments" error
        img = String()
        safe_title = String()
        num = Int()
        
        enum CodingKeys: String, CodingKey {
            case safeTitle = "safe_title"
            case img
            case num
        }
    }
    
    static func getxkcdComic(completionHandler: @escaping (Result<xkcdComic,AppError>) -> () ) {
        let url = "https://xkcd.com/info.0.json"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let xkcdData = try JSONDecoder().decode(xkcdComic.self, from: data)
                    completionHandler(.success(xkcdData))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
    
    func getSpecificComic(number: Int) -> String {
        
    }
}

//What I want to do:
//Take a user input from a textfield, make sure it's an int, and return the url with that string interpolated into the URL.
//Take a range between 1 and the most recent comic number
//When the user presses the randomize button, use a random element from within that range and interpolate it into the URL.
//I need a function that can get a comic for any URL.


