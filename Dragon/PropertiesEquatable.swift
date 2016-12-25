//
//  PropertiesEquatable.swift
//  Dragon
//
//  Created by Michael Fourre on 12/23/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol PropertiesEquatable: PropertiesAccessible
{
    func value(forKey key: String) -> Any?
}

extension PropertiesEquatable
{
    static func equal(_ left: PropertiesEquatable, _ right: PropertiesEquatable) -> Bool
    {
        let leftProperties = left.getProperties()
        let rightProperties = right.getProperties()
        for this in leftProperties
        {
            for (index, that) in rightProperties.enumerated()
            {
                guard this == that else
                {
                    guard index < rightProperties.count - 1 else { return false } //No matching properties
                    continue //Otherwise check the next property
                }
                
                guard left.value(forKey: this) != nil || right.value(forKey: that) != nil else
                {
                    break //The properties are "equal" in that they are both nil
                }
                
                if let this = left.value(forKey: this) as? PropertiesEquatable, let that = right.value(forKey: that) as? PropertiesEquatable
                {
                    //Recursively compare other PropertiesEquatable objects
                    guard equal(this, that) else { return false }
                    break
                }
                else if let this = left.value(forKey: this) as? [PropertiesEquatable], let that = right.value(forKey: that) as? [PropertiesEquatable]
                {
                    //Recursively compare arrays of other PropertiesEquatable objects
                    guard equal(this, that) else { return false }
                    break
                }
                else if let this = left.value(forKey: this) as? NSObject, let that = right.value(forKey: that) as? NSObject
                {
                    //Compare any Collection type or individual value type which is convertible to NSObject
                    guard this == that else { return false }
                    break
                }
                else
                {
                    //Cannot compare; unequal to the best of our knowledge.
                    //This condition may also be met if our object has members of unsupported type (e.g. not coercible to NSObject)
                    return false
                }
            }
        }
        return true
    }
    
    static func equal(_ these: [PropertiesEquatable], _ those: [PropertiesEquatable]) -> Bool
    {
        for (x, this) in these.enumerated()
        {
            for (y, that) in those.enumerated()
            {
                guard x == y else
                {
                    guard y != those.endIndex else { return false } //No matching properties
                    continue //Otherwise check the next property
                }
                
                //Recursively compare PropertiesEquatable objects
                guard equal(this, that) else { return false }
                break
            }
        }
        return true
    }
}

//extension PropertiesEquatable where Self: Model
//{
//    static func ==(lhs: Self, rhs: Self) -> Bool
//    {
//        return equal(lhs, rhs)
//    }
//    
//    static func !=(lhs: Self, rhs: Self) -> Bool
//    {
//        return equal(lhs, rhs)
//    }
//}
//
//extension PropertiesEquatable where Self: APIModel
//{
//    static func ==(lhs: Self, rhs: Self) -> Bool
//    {
//        return equal(lhs, rhs)
//    }
//    
//    static func !=(lhs: Self, rhs: Self) -> Bool
//    {
//        return equal(lhs, rhs)
//    }
//}
