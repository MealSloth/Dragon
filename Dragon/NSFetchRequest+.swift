//
//  NSFetchRequest+.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

extension NSFetchRequest
{
    class func FromEntityName(entityName: String?) -> NSFetchRequest?
    {
        if let name = entityName
        {
            return NSFetchRequest(entityName: name)
        }
        return nil
    }
}
