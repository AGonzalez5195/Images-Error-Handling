//
//  ComicAPIHelper.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/6/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation

//class ComicAPIHelper {
//    private init() {}
//    
//    static let shared = ComicAPIHelper()
//    let urlStr = "https://xkcd.com/614/info.0.json"
//    
//    func getConcerts(completionHandler: @escaping
//        (Result<[Comic], AppError>) -> ()) {
//        
//        NetworkManager.shared.fetchData(urlString: urlStr) {
//            (result) in
//            switch result {
//            case .failure(let error):
//                completionHandler(.failure(.noDataError))
//            case .success(let data):
//                do {
//                    let concertInfo = try JSONDecoder().decode(ConcertWrapper.self, from: data)
//                    completionHandler(.success(concertInfo.events))
//                } catch {
//                    completionHandler(.failure(.noDataError))
//                }
//            }
//        }
//    }
//}
