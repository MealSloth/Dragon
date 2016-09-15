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
            newString += (segment == stringArr.last) ? segment.lowercaseString.capitalizeFirst() : segment.lowercaseString.capitalizeFirst() + " "
        }
        return newString
    }
}
