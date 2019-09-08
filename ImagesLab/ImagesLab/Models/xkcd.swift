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
    let num: Int
    let safe_title: String
    let mostRecentComic = "https://xkcd.com/info.0.json"
    
    init() { //Required so that the code can compile without the "cannot invoke initializer with no arguments" error
        img = String()
        num = Int()
        safe_title = String()
    }
    //CodingKeys enum doesn't work with an init?
    
    static func getxkcdComic(ComicURL: String, completionHandler: @escaping (Result<xkcdComic,AppError>) -> () ) {
        
        //Reminder, this didn't initially work because you forgot to change the string passed in to the urlString parameter and instead you had it reading the most recent URL as opposed to ComicURL.
        
        NetworkManager.shared.fetchData(urlString: ComicURL) { (result) in
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
    
    func getASpecificComic(number: Int) -> String{
        return "https://xkcd.com/\(number)/info.0.json"
    }
    
    func getASpecificComicFromStepper(number:Double) -> String {
        return "https://xkcd.com/\(Int(number))/info.0.json"
    }
}
