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
    static func random(allow format: [RandomStringAllow] = [.Numeric, .AlphaLower, .AlphaUpper, ], length capacity: Int = 64) -> String
    {
        guard format.count > 0 else
        {
            preconditionFailure("Random function requires at least one value in array parameter. If no specific value is required, leave the parameter as nil.")
        }
        
        var set: String = ""
        
        for allow in format
        {
            set += allow.rawValue
        }
        
        let characters: NSMutableString = NSMutableString(string: set)
        let randomString : NSMutableString = NSMutableString(capacity: capacity)
        
        for _ in 0 ..< capacity
        {
            let length = UInt32 (characters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", characters.character(at: Int(rand)))
        }
        
        return randomString as String
    }
    
    func capitalizeFirst() -> String
    {
        var s = self
        if s.characters.count > 0
        {
            s.replaceSubrange(self.startIndex...self.startIndex, with: String(self[self.startIndex]).capitalized)
        }
        return s
    }
    
    func toDate() -> Date?
    {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        var string = self
        string = string.substring(to: self.characters.index(self.endIndex, offsetBy: -3))
        return formatter.date(from: string)
    }
}
