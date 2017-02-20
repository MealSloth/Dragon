//
//  NSDate+.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

extension Date {
    var string: String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        var string = formatter.string(from: self)
        string += "000"
        return string
    }
}
