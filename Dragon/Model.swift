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

class Model: NSManagedObject
{
    static var context: NSManagedObjectContext? {
        return AppDelegate.GetInstance()?.managedObjectContext
    }
    
    static var entityName: String? {
        let type = String(self.dynamicType)
        let distance = 0 - "Model".characters.count
        let index = type.endIndex.advancedBy(distance)
        return type.substringToIndex(index)
    }
    
    required init()
    {
        if let context = Model.context
        {
            let type = String(self.dynamicType)
            let name = type.substringToIndex(type.endIndex.advancedBy(0 - "Model".characters.count))
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
    
    //MARK: Fetch
    internal class func Fetch(predicate: NSPredicate) -> [Model?]?
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
    
    class func FromID(id: String) -> Model?
    {
        if let result = self.Fetch(NSPredicate.init(format: "id == %@", id)) where result.count > 0
        {
            return result[0]
        }
        else
        {
            Log.Warning("No \(self.entityName) found with ID \(id)")
        }
        return nil
    }
}
