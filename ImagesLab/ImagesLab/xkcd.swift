//
//  xkcd.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation



// MARK: - XKCDComic
struct xkcdComic: Codable {
    let img: String
    init() { //Required so that the code can compile without the "cannot invoke initializer with no arguments" error
        img = String()
    }
    
    static func getXKCDData(completionHandler: @escaping (Result<xkcdComic,AppError>) -> () ) {
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
    
}
