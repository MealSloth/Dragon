//
//  Fetchable.swift
//  Dragon
//
//  Created by Michael Fourre on 9/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

//
//  Supports basic CoreData fetch functions for objects which subclass NSManagedObject and
//  share their class name with the corresponding CoreData entity's name
//
protocol Fetchable: NSFetchRequestResult
{
    static var context: NSManagedObjectContext? { get }
}

extension Fetchable where Self: NSManagedObject
{
    static var entityName: String {
        return String(describing: Mirror(reflecting: self).subjectType).components(separatedBy: ".")[0]
    }
    
    static internal func fetch(_ predicate: NSPredicate? = nil, limit: Int = 0) -> [Self]?
    {
        let request: NSFetchRequest<Self> = NSFetchRequest(entityName: Self.entityName)
        request.fetchLimit = limit <= 0 ? request.fetchLimit : limit
        request.predicate = predicate
        do
        {
            return try self.context?.fetch(request)
        }
        catch let error
        {
            Log.error("\(error)")
            return nil
        }
    }
    
    static internal func from(_ key: String, inValues values: [CVarArg]?) -> [Self]?
    {
        guard let args = values else { return nil }
        return self.fetch(NSPredicate(format: "\(key) IN %@", args))
    }
    
    static internal func from(_ key: String, withValues values: [Any]?) -> [Self]?
    {
        return self.fetch(NSPredicate(format: "\(key) == %@", argumentArray: values))
    }
    
    static internal func from(_ key: String, withValue value: CVarArg?) -> [Self]?
    {
        guard let arg = value else { return nil }
        return self.fetch(NSPredicate(format: "\(key) == %@", arg))
    }
    
    static func all() -> [Self]?
    {
        return self.fetch()
    }
    
    static func top(_ count: Int? = 10) -> [Self]?
    {
        guard let limit = count else { return nil }
        return limit > 0 ? self.fetch(limit: limit) : nil
    }
    
    static func first() -> Self?
    {
        return self.top(1)?[safe: 0]
    }
    
    static func fromID(_ id: String?) -> Self?
    {
        return self.from("id", withValue: id)?[safe: 0]
    }
}
