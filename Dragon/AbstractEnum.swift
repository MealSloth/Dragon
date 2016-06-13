//
//  AbstractEnum.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol AbstractEnum
{
    
}

extension AbstractEnum
{
    func toString() -> String
    {
        var newString = ""
        let stringArr = String(self).componentsSeparatedByString("_")
        for segment in stringArr
        {
            let newSegment = segment.substringWithRange(segment.characters.startIndex..<(segment.characters.startIndex.advancedBy(1))).capitalizedString + segment.substringWithRange(segment.characters.startIndex.advancedBy(1)..<segment.characters.endIndex).lowercaseString
            newString += (segment == stringArr.last) ? newSegment : newSegment + " "
        }
        return newString
    }
}