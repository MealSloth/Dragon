//
//  PropertiesAccessible.swift
//  Dragon
//
//  Created by Michael Fourre on 12/23/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import CoreData

protocol PropertiesAccessible {
    
}

extension PropertiesAccessible {
    func getProperties() -> [String] {
        if let context = self as? NSManagedObject {
            return context.entity.attributesByName.map({ $0.key })
        } else {
            return Mirror(reflecting: self).children.filter({ $0.label != nil }).map({ $0.label! })
        }
    }
}
