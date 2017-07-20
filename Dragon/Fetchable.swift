//
//  Fetchable.swift
//  Dragon
//
//  Created by Michael Fourre on 9/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import CoreData

//
//  Supports basic CoreData fetch functions for objects which subclass NSManagedObject and
//  share their class name with the corresponding CoreData entity's name
//
protocol Fetchable: NSFetchRequestResult {
    static var context: NSManagedObjectContext? { get }
}

extension Fetchable where Self: NSManagedObject {
    static var entityName: String? {
        return String(describing: Mirror(reflecting: self).subjectType).components(separatedBy: ".").first
    }
    
    static func fetch(predicates: [NSPredicate]?, sorts: [NSSortDescriptor]?, limit: Int) -> [Self]? {
        guard let entityName = self.entityName else {
            Log.error("Cannot acquire entity name")
            return nil
        }
        let request: NSFetchRequest<Self> = NSFetchRequest(entityName: entityName)
        request.fetchLimit = limit <= 0 ? request.fetchLimit : limit
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates ?? [])
        request.sortDescriptors = sorts
        guard let result = try? self.context?.fetch(request), result?.first != nil else { return nil }
        return result
    }
    
    static func from(predicateMap: [String:Any]? = [:], sortMap: [String:Bool]? = [:], limit: Int = 0) -> [Self]? {
        let predicates: [NSPredicate] = predicateMap?.map({ NSPredicate(format: "\($0.key) IN %@", $0.value as? [Any] ?? [$0.value, ]) }) ?? []
        let sorts: [NSSortDescriptor] = sortMap?.map({ NSSortDescriptor(key: $0.key, ascending: $0.value) }) ?? []
        return self.fetch(predicates: predicates, sorts: sorts, limit: limit)
    }
    
    static func from(_ key: String?, inValues values: [Any]?, sortBy sortKey: String? = nil, ascending: Bool = true, limit: Int = 0) -> [Self]? {
        guard let key = key, let values = values, values.first != nil else { return nil } //Do not allow querying by nil in this function
        guard let sort = sortKey else { return self.from(predicateMap: [key: values, ], sortMap: nil, limit: limit) }
        return self.from(predicateMap: [key: values, ], sortMap: [sort: ascending, ], limit: limit)
    }
    
    static func from(_ key: String?, withValue value: Any?, sortBy sortKey: String? = nil, ascending: Bool = true, limit: Int = 0) -> [Self]? {
        guard let value = value else { return nil } //Do not allow querying by nil in this function
        return self.from(key, inValues: [value, ], sortBy: sortKey, ascending: ascending, limit: limit)
    }
    
    static func sortBy(key sortKey: String?, ascending: Bool = true, limit: Int = 0) -> [Self]? {
        guard let sort = sortKey else { return nil } //Do not allow sorting by nil in this function
        return self.from(sortMap: [sort: ascending, ], limit: limit)
    }
    
    static func all() -> [Self]? {
        return self.from()
    }
    
    static func top(_ count: Int?) -> [Self]? {
        guard let limit = count, limit > 0 else { return nil }
        return self.from(limit: limit)
    }
    
    static func first() -> Self? {
        return self.top(1)?.first
    }
    
    static func fromID(_ id: String?) -> Self? {
        return self.from("id", withValue: id)?.first
    }
}
