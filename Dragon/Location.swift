//
//  Location.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Location: Model {
    @NSManaged var id: String!
    @NSManaged var userID: String!
    @NSManaged var purpose: NSNumber!
    @NSManaged var type: NSNumber!
    @NSManaged var addressLineOne: String!
    @NSManaged var addressLineTwo: String?
    @NSManaged var city: String!
    @NSManaged var state: String?
    @NSManaged var country: String?
    @NSManaged var zip: String?
    
    var locationPurpose: LocationPurpose? {
        get { return LocationPurpose(rawValue: self.purpose.intValue) }
        set { if let value = newValue?.rawValue { self.purpose = NSNumber(value: value) } }
    }
    
    var locationType: LocationType? {
        get { return LocationType(rawValue: self.type.intValue) }
        set { if let value = newValue?.rawValue { self.type = NSNumber(value: value) } }
    }
}
