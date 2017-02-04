//
//  PropertiesEquatable.swift
//  Dragon
//
//  Created by Michael Fourre on 12/23/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol PropertiesEquatable: PropertiesAccessible {
    func value(forKey key: String) -> Any?
}

extension PropertiesEquatable {
    static func equal(_ left: PropertiesEquatable, _ right: PropertiesEquatable) -> Bool {
        let leftProperties = left.getProperties()
        let rightProperties = right.getProperties()
        for this in leftProperties {
            for (index, that) in rightProperties.enumerated() {
                guard this == that else {
                    guard index < rightProperties.count - 1 else { return false }
                    continue
                }
                
                guard left.value(forKey: this) != nil || right.value(forKey: that) != nil else {
                    break
                }
                
                if let this = left.value(forKey: this) as? PropertiesEquatable, let that = right.value(forKey: that) as? PropertiesEquatable {
                    guard equal(this, that) else { return false }
                    break
                } else if let this = left.value(forKey: this) as? [PropertiesEquatable], let that = right.value(forKey: that) as? [PropertiesEquatable] {
                    guard equal(this, that) else { return false }
                    break
                } else if let this = left.value(forKey: this) as? NSObject, let that = right.value(forKey: that) as? NSObject {
                    guard this == that else { return false }
                    break
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    static func equal(_ these: [PropertiesEquatable], _ those: [PropertiesEquatable]) -> Bool {
        guard these.count == those.count else { return false }
        for i in 0..<these.count where !equal(these[i], those[i]) { return false }
        return true
    }
}
