//
//  Model.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import CoreData
import UIKit

class Model: NSManagedObject, Manageable, PrettyPrintable, PropertiesEquatable, ChildrenIdentifiable {
    override var description: String {
        return self.getPropertiesString(self)
    }
    
    static var children: [Model.Type] = {
        return Model.getChildren()
    }()
    
    static var coordinator: NSPersistentStoreCoordinator? {
        return AppDelegate.instance?.persistentStoreCoordinator
    }
    
    static var context: NSManagedObjectContext? {
        return AppDelegate.instance?.managedObjectContext
    }
    
    //MARK: Initializers
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required init() {
        if let context = Model.context {
            let name = String(describing: type(of: self))
            if let currentEntity = NSEntityDescription.entity(forEntityName: name, in: context) {
                super.init(entity: currentEntity, insertInto: context)
            } else {
                Log.error("No entity found with name: \(name)")
                super.init()
            }
        } else {
            Log.error("Could not retrieve managedObjectContext from AppDelegate")
            super.init()
        }
    }
    
    //MARK: KVC Overrides
    override func value(forKey key: String) -> Any? {
        return self.value(for: key)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        self.set(value, for: key)
    }
    
    //MARK: KVC Interfaces with less redundancy
    func value(for key: String) -> Any? {
        return super.value(forKey: key)
    }
    
    func set(_ value: Any?, for key: String) {
        if TypeHelper.type(from: key, ofObject: self) == .dateAttributeType {
            if let dateString = value as? String, let date = dateString.date {
                super.setValue(date, forKey: key)
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    //MARK: Initialization helpers
    func populate(using model: APIModel?, skip: [String] = []) {
        guard let model = model else { return }
        for property in model.getProperties()
            where self.getProperties().contains(property) && !skip.contains(property) {
            self.set(model.value(for: property), for: property)
        }
    }
    
    //MARK: Global Model functions
    static internal func deleteAllChildren() {
        for child in Model.children {
            child.deleteAll()
        }
    }
    
    //MARK: Comparison operators
    static func ==(lhs: Model, rhs: Model) -> Bool {
        return equal(lhs, rhs)
    }
    
    static func !=(lhs: Model, rhs: Model) -> Bool {
        return !equal(lhs, rhs)
    }
}
