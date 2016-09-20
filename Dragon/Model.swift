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

class Model: NSManagedObject, Fetchable, PrettyPrintable
{
    static var context: NSManagedObjectContext? {
        return AppDelegate.getInstance()?.managedObjectContext
    }
    
    static var entityName: String {
        return String(describing: type(of: self))
    }
    
    override var description: String {
        return self.getPropertiesString(self)
    }
    
    //MARK: Initializers
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
    
    convenience init(_ model: APIModel)
    {
        self.init()
        self.initialize(model)
    }
    
    //MARK: Overrides
    override func value(forKey key: String) -> Any?
    {
        return super.value(forKey: key)
    }
    
    //MARK: Initialization helpers
    func initialize(_ model: APIModel, skip: [String] = [])
    {
        for property in model.getProperties() where !skip.contains(property)
        {
            let value = model.value(forKey: property)
            if let dateString = value as? String, let date = dateString.toDate()
            {
                self.setValue(date, forKey: property)
            }
            else
            {
                self.setValue(model.value(forKey: property), forKey: property)
            }
        }
    }
}
