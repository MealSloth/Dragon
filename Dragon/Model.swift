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

class Model: NSManagedObject, Manageable, PrettyPrintable, ChildrenIdentifiable
{
    override var description: String {
        return self.getPropertiesString(self)
    }
    
    static var children: [Model.Type] = {
        return Model.getChildren()
    }()
    
    static var coordinator: NSPersistentStoreCoordinator? {
        return AppDelegate.getInstance()?.persistentStoreCoordinator
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
    
    override func setValue(_ value: Any?, forKey key: String)
    {
        if TypeHelper.type(from: key, ofObject: self) == .dateAttributeType
        {
            if let dateString = value as? String, let date = dateString.toDate()
            {
                super.setValue(date, forKey: key)
            }
        }
        else
        {
            super.setValue(value, forKey: key)
        }
    }
    
    //MARK: Initialization helpers
    func populate(using model: APIModel?, skip: [String] = [])
    {
        guard let model = model else { return }
        for property in model.getProperties()
            where self.getProperties().contains(property) && !skip.contains(property)
        {
            self.setValue(model.value(forKey: property), forKey: property)
            
        }
    }
    
    //MARK: Global Model functions
    static internal func deleteAllChildren()
    {
        for child in Model.children
        {
            child.deleteAll()
        }
    }
    
    //MARK: Comparison operations
    static func ==(left: Model, right: Model) -> Bool
    {
        if left === right //Don't bother computing as long as the identity is the same
        {
            return true
        }
        for these in left.getProperties()
        {
            let properties = right.getProperties()
            for (index, those) in properties.enumerated()
            {
                if these == those //Matching property
                {
                    if compare(a: left.value(forKey: these), b: right.value(forKey: those))
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
                    if index >= properties.count - 1 //No matching properties
                    {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    //MARK: Comparison helpers
    static func compare(a: Any?, b: Any?) -> Bool
    {
        if let this = a as? [Any], let that = b as? [Any] //Handle Arrays
        {
            for i in 0..<this.count
            {
                if !compare(a: this[safe: i], b: that[safe: i]) //Recursively compare array elements
                {
                    return false
                }
            }
            return true
        }
        else //Handle Equatable objects
        {
            if let this = a as? String, let that = b as? String, this == that
            {
                return true
            }
            else if let this = a as? Date, let that = b as? Date, this == that
            {
                return true
            }
            else if let this = a as? NSNumber, let that = b as? NSNumber, this == that
            {
                return true
            }
            else if let this = a as? Model, let that = b as? Model, this == that //Recursively compare Model
            {
                return true
            }
            else
            {
                return false //Cannot compare; return false
            }
        }
    }
}
