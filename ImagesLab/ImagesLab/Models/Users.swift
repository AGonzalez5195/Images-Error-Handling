//
//  Users.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation

struct usersModel: Codable {
    let results: [userResults]
    
    static func getUserData(completionHandler: @escaping (Result<[userResults],AppError>) -> () ) {
        let url = "https://randomuser.me/api/?results=100"
        
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let userData = try JSONDecoder().decode(usersModel.self, from: data)
                    completionHandler(.success(userData.results))
                } catch {
                    completionHandler(.failure(.badJSONError))                }
            }
        }
    }
}

struct userResults: Codable {
    let name: userNameWrapper
    let location: locationWrapper
    let phone: String
    let cell: String
    var dob: dobWrapper
    let picture: pictureWrapper
    
    
    func getFullName() -> String {
        let firstName = name.first.capitalized
        let lastName = name.last.capitalized
        
        return "\(firstName) \(lastName)"
    }
    
    func getLocation() -> String {
        let street = location.street.capitalized
        let city = location.city.capitalized
        let state = location.state.capitalized
        
        return "\(street), \(city), \(state)"
    }
}

struct userNameWrapper: Codable {
    let first: String
    let last: String
}

struct locationWrapper: Codable {
    let street: String
    let city: String
    let state: String
}

struct dobWrapper: Codable {
    let age: Int
}

struct pictureWrapper: Codable {
    let large: String
}

