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

class Model: NSManagedObject, PrettyPrintable
{
    static var context: NSManagedObjectContext? {
        return AppDelegate.GetInstance()?.managedObjectContext
    }
    
    static var entityName: String? {
        return String(self.dynamicType)
    }
    
    override var description: String {
        return self.getPropertiesString(self)
    }
    
    //MARK: Initializers
    required init()
    {
        if let context = Model.context
        {
            let name = String(self.dynamicType)
            if let currentEntity = NSEntityDescription.entityForName(name, inManagedObjectContext: context)
            {
                super.init(entity: currentEntity, insertIntoManagedObjectContext: context)
            }
            else
            {
                Log.Error("No entity found with name: \(name)")
                super.init()
            }
        }
        else
        {
            Log.Error("Could not retrieve managedObjectContext from AppDelegate")
            super.init()
        }
    }
    
    convenience init(_ model: APIModel)
    {
        self.init()
        self.initialize(model)
    }
    
    //MARK: Overrides
    override func valueForKey(key: String) -> AnyObject?
    {
        return super.valueForKey(key)
    }
    
    //MARK: Initialization helpers
    func initialize(model: APIModel, skip: [String] = [])
    {
        for property in model.getProperties()
        {
            if !skip.contains(property)
            {
                let value = model.valueForKey(property)
                if let dateString = value as? String, let date = dateString.toDate()
                {
                    self.setValue(date, forKey: property)
                }
                else
                {
                    self.setValue(model.valueForKey(property), forKey: property)
                }
            }
        }
    }
    
    //MARK: Fetch
    internal class func Fetch(predicate: NSPredicate) -> [Model]?
    {
        do
        {
            if let request = NSFetchRequest.FromEntityName(self.entityName)
            {
                request.predicate = predicate
                if let result = try self.context?.executeFetchRequest(request) as? [Model]
                {
                    return result
                }
            }
        }
        catch let error as NSError
        {
            Log.Error("\(error)")
        }
        return nil
    }
    
    //MARK: Fetch where
    class func FromID<T: Model>(id: String) -> T?
    {
        if let result = self.Fetch(NSPredicate.init(format: "id == %@", id)) where result.count > 0
        {
            if let first = result[0] as? T
            {
                return first
            }
        }
        Log.Warning("No \(self.entityName) found with ID \(id)")
        return nil
    }
}
