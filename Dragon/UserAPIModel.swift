//
//  UserAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserAPIModel: APIModel
{
    var id: String!
    var userLoginID: String!
    var consumerID: String!
    var chefID: String!
    var locationID: String!
    var billingID: String!
    var profilePhotoID: String!
    var email: String!
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var dateOfBirth: String?
    var gender: NSNumber?
}