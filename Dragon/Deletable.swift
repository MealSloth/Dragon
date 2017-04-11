//
//  Deletable.swift
//  Dragon
//
//  Created by Michael Fourre on 10/9/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import CoreData

//
//  Supports basic CoreData removal functions for objects which subclass NSManagedObject and
//  share their class name with the corresponding CoreData entity's name
//
protocol Deletable {
    static var context: NSManagedObjectContext? { get set }
}

extension Deletable where Self: NSManagedObject {
    func delete() {
        Self.context?.delete(self)
    }
}

extension Deletable where Self: NSManagedObject {
    static var entityName: String? {
        return String(describing: Mirror(reflecting: self).subjectType).components(separatedBy: ".").first
    }
    
    static func delete(_ predicate: NSPredicate? = nil) {
        guard let entityName = self.entityName else {
            Log.error("Cannot acquire entity name")
            return
        }
        let request: NSFetchRequest<Self> = NSFetchRequest(entityName: entityName)
        request.predicate = predicate
        let result = try? self.context?.fetch(request)
        result??.forEach({ self.context?.delete($0) })
        try? self.context?.save()
    }
    
    static func deleteFrom(_ key: String, inValues values: [Any]?) {
        guard let args = values else { return }
        self.delete(NSPredicate(format: "\(key) IN %@", args))
    }
    
    static func deleteFrom(_ key: String, withValue value: Any?) {
        guard let arg = value else { return }
        self.deleteFrom(key, inValues: [arg, ])
    }
    
    static func delete(withID id: String?) {
        self.deleteFrom("id", withValue: id)
    }
    
    static func deleteAll() {
        self.delete()
    }
}
