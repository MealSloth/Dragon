//
//  Updatable.swift
//  Dragon
//
//  Created by Michael Fourre on 10/10/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import CoreData

//
//  Supports basic CoreData update functions for objects which subclass NSManagedObject
//
protocol Updatable {
    static var context: NSManagedObjectContext? { get set }
}

extension Updatable where Self: NSManagedObject {
    func save() {
        try? Self.context?.save()
    }
}
