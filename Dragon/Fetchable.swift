//
//  Fetchable.swift
//  Dragon
//
//  Created by Michael Fourre on 9/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

protocol Fetchable
{
    static var entityName: String { get }
    static var context: NSManagedObjectContext? { get }
}

extension Fetchable where Self: NSManagedObject
{
    internal static func fetch(predicate: NSPredicate? = nil) -> [Self]?
    {
        do
        {
            if let request = NSFetchRequest.fromEntityName(self.entityName)
            {
                request.predicate = predicate
                if let result = try self.context?.executeFetchRequest(request) as? [Self]
                {
                    return result
                }
            }
        }
        catch let error as NSError
        {
            Log.error("\(error)")
        }
        return nil
    }
    
    static func all() -> [Self]?
    {
        if let result = self.fetch()
        {
            return result
        }
        Log.warning("No \(self.entityName) found")
        return nil
    }
    
    static func first() -> Self?
    {
        if let result = self.fetch()?[safe: 0]
        {
            return result
        }
        Log.warning("No \(self.entityName) found")
        return nil
    }
    
    static func first(count: Int = 1) -> [Self]?
    {
        if count > 0, let result = self.fetch() where result.count > 0
        {
            return result
        }
        Log.warning("No \(self.entityName) found")
        return nil
    }
    
    static func fromID(id: String?) -> Self?
    {
        if let val = id
        {
            return self.fetch(NSPredicate(format: "id == %@", val))?[safe: 0]
        }
        Log.warning("No \(self.entityName) found with ID \(id)")
        return nil
    }
}
