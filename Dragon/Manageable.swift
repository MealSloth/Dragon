//
//  Manageable.swift
//  Dragon
//
//  Created by Michael Fourre on 10/10/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import CoreData

//
//  Manageable is simply a collective protocol which implements all available DB protocols
//

protocol Manageable: Deletable, Fetchable, Insertable, Updatable {
    static var context: NSManagedObjectContext? { get }
}
