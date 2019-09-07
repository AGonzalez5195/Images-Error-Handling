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
