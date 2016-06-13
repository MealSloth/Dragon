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
    
//    override func initialize(json: Dictionary<String, AnyObject>)
//    {
//        self.id = json["id"] as! String
//        self.userLoginID = json["user_login_id"] as! String
//        self.consumerID = json["consumer_id"] as! String
//        self.chefID = json["chef_id"] as! String
//        self.locationID = json["location_id"] as! String
//        self.billingID = json["billing_id"] as! String
//        self.profilePhotoID = json["profile_photo_id"] as! String
//        self.email = json["email"] as! String
//        self.firstName = json["first_name"] as? String
//    }
}