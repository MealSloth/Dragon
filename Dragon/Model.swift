//
//  Model.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Model: NSManagedObject, Manageable, PrettyPrintable
{
    override var description: String {
        return self.getPropertiesString(self)
    }
    
    static var context: NSManagedObjectContext? {
        return AppDelegate.getInstance()?.managedObjectContext
    }
    
    //MARK: Initializers
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?)
    {
        super.init(entity: entity, insertInto: context)
    }
    
    required init()
    {
        if let context = Model.context
        {
            let name = String(describing: type(of: self))
            if let currentEntity = NSEntityDescription.entity(forEntityName: name, in: context)
            {
                super.init(entity: currentEntity, insertInto: context)
            }
            else
            {
                Log.error("No entity found with name: \(name)")
                super.init()
            }
        }
        else
        {
            Log.error("Could not retrieve managedObjectContext from AppDelegate")
            super.init()
        }
    }
    
    //MARK: Overrides
    override func value(forKey key: String) -> Any?
    {
        return super.value(forKey: key)
    }
    
    //MARK: Initialization helpers
    func populate(using model: APIModel, skip: [String] = [])
    {
        for property in model.getProperties()
            where self.getProperties().contains(property) && !skip.contains(property)
        {
            let value = model.value(forKey: property)
            if let dateString = value as? String, let date = dateString.toDate()
            {
                self.setValue(date, forKey: property)
            }
            else
            {
                self.setValue(value, forKey: property)
            }
        }
    }
    
    //MARK: Comparison operations
    static func ==(left: Model, right: Model) -> Bool
    {
        for these in left.getProperties()
        {
            let properties = right.getProperties()
            for (index, those) in properties.enumerated()
            {
                if these == those
                {
                    //TODO: Use Equatable protocol instead of individual type casts for expected members
                    if let this = left.value(forKey: these) as? String, let that = right.value(forKey: those) as? String, this == that
                    {
                        break
                    }
                    else if let this = left.value(forKey: these) as? Date, let that = right.value(forKey: those) as? Date, this == that
                    {
                        break
                    }
                    else if let this = left.value(forKey: these) as? NSNumber, let that = right.value(forKey: those) as? NSNumber, this == that
                    {
                        break
                    }
                    else if let this = left.value(forKey: these) as? Model, let that = right.value(forKey: those) as? Model, this == that
                    {
                        break
                    }
                    else
                    {
                        return false
                    }
                }
                else
                {
                    if index >= properties.count - 1
                    {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    static func !=(left: Model, right: Model) -> Bool
    {
        return !(left == right) //lol
    }
}
