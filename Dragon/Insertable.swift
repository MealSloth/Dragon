//
//  Insertable.swift
//  Dragon
//
//  Created by Michael Fourre on 10/9/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

//
//  Supports basic CoreData insert functions for objects which subclass NSManagedObject and
//  share their class name with the corresponding CoreData entity's name
//
protocol Insertable
{
    static var context: NSManagedObjectContext? { get }
    func populate(using model: APIModel?, skip: [String])
}

extension Insertable where Self: NSManagedObject
{
    static var entityName: String {
        return String(describing: Mirror(reflecting: self).subjectType).components(separatedBy: ".")[0]
    }
    
    static internal func insert(at id: String?, into table: String?) -> Self?
    {
        guard let context = self.context, let id = id else
        {
            Log.error("Cannot retrieve object from managed object context")
            return nil
        }
        let tableName = table ?? self.entityName
        let request: NSFetchRequest<Self> = NSFetchRequest(entityName: tableName)
        request.predicate = NSPredicate(format: "id == %@", id)
        if let result = try? context.fetch(request), let object = result.first
        {
            return object
        }
        else if let entity = NSEntityDescription.entity(forEntityName: tableName, in: context)
        {
            return self.init(entity: entity, insertInto: context)
        }
        return nil
    }
    
    static func insert(_ model: APIModel?, into table: String?) -> Self?
    {
        guard let object = Self.insert(at: model?.value(forKey: "id") as? String, into: table) else { return nil }
        object.populate(using: model, skip: [])
        try? self.context?.save()
        return object
    }
    
    static func insert(_ model: APIModel?) -> Self?
    {
        return self.insert(model, into: self.entityName)
    }
}
