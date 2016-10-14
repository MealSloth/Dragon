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

class Model: NSManagedObject, Manageable, PrettyPrintable
{
    override var description: String {
        return self.getPropertiesString(self)
    }
    
    static var context: NSManagedObjectContext? {
        return AppDelegate.getInstance()?.managedObjectContext
    }
    
    //MARK: Initializers
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?)
    {
        super.init(entity: entity, insertInto: context)
    }
    
    required init()
    {
        if let context = Model.context
        {
            let name = String(describing: type(of: self))
            if let currentEntity = NSEntityDescription.entity(forEntityName: name, in: context)
            {
                super.init(entity: currentEntity, insertInto: context)
            }
            else
            {
                Log.error("No entity found with name: \(name)")
                super.init()
            }
        }
        else
        {
            Log.error("Could not retrieve managedObjectContext from AppDelegate")
            super.init()
        }
    }
    
    @available(iOS, deprecated: 0.0.5, message: "Use Insertable static func insertOrUpdate instead")
    convenience init(_ model: APIModel)
    {
        self.init()
        self.populate(using: model)
        do
        {
            try self.managedObjectContext?.save()
        }
        catch let error
        {
            Log.error("Error initializing Model with APIModel: \(error)")
        }
    }
    
    //MARK: Overrides
    override func value(forKey key: String) -> Any?
    {
        return super.value(forKey: key)
    }
    
    //MARK: Initialization helpers
    func populate(using model: APIModel, skip: [String] = [])
    {
        for property in model.getProperties()
            where self.getProperties().contains(property) && !skip.contains(property)
        {
            let value = model.value(forKey: property)
            if let dateString = value as? String, let date = dateString.toDate()
            {
                self.setValue(date, forKey: property)
            }
            else
            {
                self.setValue(value, forKey: property)
            }
        }
    }
}
