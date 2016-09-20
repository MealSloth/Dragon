//
//  User.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class User: Model
{
    @NSManaged var id: String!
    @NSManaged var userLoginID: String!
    @NSManaged var consumerID: String!
    @NSManaged var chefID: String!
    @NSManaged var locationID: String!
    @NSManaged var billingID: String!
    @NSManaged var profilePhotoID: String!
    @NSManaged var email: String!
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var dateOfBirth: Date?
    @NSManaged var gender: NSNumber?
}
