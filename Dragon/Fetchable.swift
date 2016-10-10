//
//  Fetchable.swift
//  Dragon
//
//  Created by Michael Fourre on 9/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

protocol Fetchable: NSFetchRequestResult
{
    static var context: NSManagedObjectContext? { get }
}

extension Fetchable where Self: NSManagedObject
{
    static var entityName: String {
        return String(describing: Mirror(reflecting: self).subjectType).components(separatedBy: ".")[0]
    }
    
    static internal func fetch(_ predicate: NSPredicate? = nil) -> [Self]?
    {
        let request: NSFetchRequest<Self> = NSFetchRequest(entityName: Self.entityName)
        request.predicate = predicate
        do
        {
            return try self.context?.fetch(request)
        }
        catch let error
        {
            Log.error("\(error)")
        }
        return nil
    }
    
    static internal func from(_ key: String, withValues values: [Any]?) -> [Self]?
    {
        return self.fetch(NSPredicate(format: "\(key) == %@", argumentArray: values))
    }
    
    static internal func from(_ key: String, withValue value: CVarArg?) -> [Self]?
    {
        if let arg = value
        {
            return self.fetch(NSPredicate(format: "\(key) == %@", arg))
        }
        else
        {
            Log.error("Received nil value parameter")
            return nil
        }
    }
    
    static func all() -> [Self]?
    {
        if let result = self.fetch()
        {
            return result
        }
        Log.error("No \(self.entityName) entities found")
        return nil
    }
    
    static func top(_ count: Int = 1) -> [Self]?
    {
        if count > 0, let result = self.fetch(), result.count > 0
        {
            return result
        }
        Log.error("No \(self.entityName) entities found")
        return nil
    }
    
    static func first() -> Self?
    {
        if let result = self.fetch()?[safe: 0]
        {
            return result
        }
        Log.error("No \(self.entityName) entities found")
        return nil
    }
    
    static func fromID(_ id: String?) -> Self?
    {
        return self.from("id", withValue: id)?[safe: 0]
    }
}
