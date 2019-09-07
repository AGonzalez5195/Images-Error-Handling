//
//  Extensions.swift
//  ImagesLab
//
//  Created by Anthony Gonzalez on 9/7/19.
//  Copyright © 2019 Anthony. All rights reserved.
//

import Foundation

extension String {
    func toInt() -> Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
}

func sortByNameAscending(userArrayToSort: [userResults]) -> [userResults] {
    var sortedUsers = userArrayToSort
    sortedUsers = userArrayToSort.sorted(by: {$0.getFullName() < $1.getFullName()})
    return sortedUsers
}


