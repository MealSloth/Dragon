//
//  UserAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserAPIModel : AbstractAPIModel
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
    var gender: Int?
    
    override func initialize(json: Dictionary<String, AnyObject>, skip: [String])
    {
        let skip: [String] = ["gender", ]
        if let jsonGender = json["gender"] as? Int
        {
            self.gender = jsonGender
        }
        super.initialize(json, skip: skip)
    }
}