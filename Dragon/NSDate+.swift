//
//  NSDate+.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

extension NSDate
{
    func toString() -> String
    {
        let formatter = NSDateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        var string = formatter.stringFromDate(self)
        string = string.stringByReplacingOccurrencesOfString(" ", withString: "T")
        string += "000"
        return string
    }
}