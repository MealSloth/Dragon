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
    
    static internal func fetch(_ predicate: NSPredicate? = nil, sortBy sorts: [NSSortDescriptor]? = nil, limit: Int = 0) -> [Self]?
    {
        let request: NSFetchRequest<Self> = NSFetchRequest(entityName: Self.entityName)
        request.fetchLimit = limit <= 0 ? request.fetchLimit : limit
        request.predicate = predicate
        request.sortDescriptors = sorts
        if let result = try? self.context?.fetch(request)
        {
            return result
        }
        return nil
    }
    
    static internal func from(_ key: String? = nil, inValues values: [Any]? = nil, sortBy sortKey: String? = nil, ascending: Bool = true, limit: Int = 0) -> [Self]?
    {
        guard let key = key, let values = values else
        {
            return self.fetch(nil, sortBy: sortKey == nil ? nil : [NSSortDescriptor(key: sortKey, ascending: ascending), ], limit: limit)
        }
        guard let sort = sortKey else
        {
            return self.fetch(NSPredicate(format: "\(key) IN %@", values), sortBy: nil, limit: limit)
        }
        return self.fetch(NSPredicate(format: "\(key) IN %@", values), sortBy: [NSSortDescriptor(key: sort, ascending: ascending), ], limit: limit)
    }
    
    static internal func from(_ key: String?, withValue value: Any?, sortBy sortKey: String? = nil, ascending: Bool = true, limit: Int = 0) -> [Self]?
    {
        guard let key = key, let value = value else { return self.from(nil, inValues: nil, sortBy: sortKey, ascending: ascending, limit: limit) }
        return self.from(key, inValues: [value, ], sortBy: sortKey, ascending: ascending, limit: limit)
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
        return self.from("id", withValue: id)?.first
    }
}
