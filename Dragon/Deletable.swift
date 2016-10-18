//
//  Deletable.swift
//  Dragon
//
//  Created by Michael Fourre on 10/9/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

protocol Deletable
{
    static var context: NSManagedObjectContext? { get }
}

//
//  Supports basic CoreData removal functions for objects which subclass NSManagedObject and
//  share their class name with the corresponding CoreData entity's name
//
extension Deletable where Self: NSManagedObject
{
    static var entityName: String {
        return String(describing: Mirror(reflecting: self).subjectType).components(separatedBy: ".")[0]
    }
    
    static internal func delete(_ predicate: NSPredicate? = nil)
    {
        if let context = self.context
        {
            let request: NSFetchRequest<Self> = NSFetchRequest(entityName: self.entityName)
            request.predicate = predicate
            do
            {
                let results = try context.fetch(request)
                for result in results
                {
                    context.delete(result)
                }
                do
                {
                    try self.context?.save()
                }
                catch let error
                {
                    Log.error("Error while attempting to save managed object context during delete: \(error)")
                }
            }
            catch let error
            {
                Log.error("Error during fetch request: \(error)")
            }
        }
        else
        {
            Log.error("Could not get managed object context")
        }
    }
    
    static internal func deleteFrom(_ key: String, withValues values: [Any]?)
    {
        return self.delete(NSPredicate(format: "\(key) == %@", argumentArray: values))
    }
    
    static internal func deleteFrom(_ key: String, withValue value: CVarArg?)
    {
        if let val = value
        {
            self.delete(NSPredicate(format: "\(key) == %@", val))
        }
        else
        {
            Log.error("Received nil value parameter")
        }
    }
    
    static func deleteAll()
    {
        self.delete()
    }
    
    static func delete(withID id: String?)
    {
        self.deleteFrom("id", withValue: id)
    }
}
