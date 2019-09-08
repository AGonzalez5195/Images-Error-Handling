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
    
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date = dateFormatter.date(from: self)
        return date
    }
    
    func toDateFormatInString(dateFormat: String) -> String {
        let Date = toDate(dateFormat: dateFormat)
        let formatter = DateFormatter()
        
        guard let date = Date else {return "No Date Found"}
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: date)
    }
    
    func changeDateFormatForHeader(dateFormat: String) -> String {
        let Date = toDate(dateFormat: dateFormat)
        let formatter = DateFormatter()
        
        guard let date = Date else {return "No Date Found"}
        formatter.dateFormat = "MM/yyyy"
        return formatter.string(from: date)
    }
}

extension Date {
    static func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) ->String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = fromFormat
        let date = inputDateFormatter.date(from: dateString)
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = toFormat
        return outputDateFormatter.string(from: date!)
    }
}
func sortByNameAscending(userArrayToSort: [userResults]) -> [userResults] {
    var sortedUsers = userArrayToSort
    sortedUsers = userArrayToSort.sorted(by: {$0.getFullName() < $1.getFullName()})
    return sortedUsers
}


