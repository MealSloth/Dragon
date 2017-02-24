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
    var properties: [String] {
        if let context = self as? NSManagedObject {
            return context.entity.attributesByName.map({ $0.key })
        } else {
            return Mirror(reflecting: self).children.flatMap({ $0.label })
        }
    }
}
