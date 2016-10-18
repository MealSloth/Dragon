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
    func populate(using model: APIModel, skip: [String])
}

extension Insertable where Self: NSManagedObject
{
    static var entityName: String {
        return String(describing: Mirror(reflecting: self).subjectType).components(separatedBy: ".")[0]
    }
    
    static internal func insertOrUpdate(_ id: String?) -> Self?
    {
        if let context = self.context, let id = id
        {
            let request: NSFetchRequest<Self> = NSFetchRequest(entityName: self.entityName)
            request.predicate = NSPredicate(format: "id == %@", id)
            do
            {
                let result = try context.fetch(request)
                if let object = result[safe: 0]
                {
                    return object
                }
                else
                {
                    if let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context)
                    {
                        return self.init(entity: entity, insertInto: context)
                    }
                    else
                    {
                        Log.error("No entity found with name: \(self.entityName)")
                        return nil
                    }
                }
            }
            catch let error
            {
                Log.error("Error during fetch request: \(error)")
                return nil
            }
        }
        else
        {
            Log.error("Cannot retrieve object from managed object context")
            return nil
        }
    }
    
    static func insertOrUpdate(_ model: APIModel) -> Self?
    {
        if let object = Self.insertOrUpdate(model.value(forKey: "id") as? String)
        {
            object.populate(using: model, skip: [])
            do
            {
                try self.context?.save()
                return object
            }
            catch let error
            {
                Log.error("Error during context save: \(error)")
                return nil
            }
        }
        else
        {
            Log.error("Error during insertOrUpdate")
            return nil
        }
    }
}
