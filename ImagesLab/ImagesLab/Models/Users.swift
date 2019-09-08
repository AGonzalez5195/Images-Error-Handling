//
//  Users.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation

struct usersModel: Codable {
    let results: [User]
    
    static func getUserData(completionHandler: @escaping (Result<[User],AppError>) -> () ) {
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

struct User: Codable {
    let name: Name
    let location: Location
    let phone: String
    let cell: String
    var dob: DoB
    let picture: Picture
    
    
    static func getSortedArray(arr: [User]) -> [User] {
        let sortedArr = arr.sorted{$0.getFullName() < $1.getFullName()}
        return sortedArr
    }
    
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

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let street: String
    let city: String
    let state: String
}

struct DoB: Codable {
    let age: Int
}

struct Picture: Codable {
    let large: String
}

