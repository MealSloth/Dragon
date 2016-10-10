//
//  Updatable.swift
//  Dragon
//
//  Created by Michael Fourre on 10/10/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

protocol Updatable
{
    static var context: NSManagedObjectContext? { get }
}

extension Updatable where Self: NSManagedObject
{
    func save()
    {
        if let context = Self.context
        {
            do
            {
                try context.save()
            }
            catch let error
            {
                Log.error("Error during save: \(error)")
            }
        }
        else
        {
            Log.error("Could not get managed object context during save")
        }
    }
}
