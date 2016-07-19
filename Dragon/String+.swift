//
//  String+.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

extension String
{
    func toDate() -> NSDate?
    {
        let formatter = NSDateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        var string = self
        string = string.stringByReplacingOccurrencesOfString("T", withString: " ")
        string = string.substringFromIndex(self.endIndex.advancedBy(-3))
        return formatter.dateFromString(string)
    }
}