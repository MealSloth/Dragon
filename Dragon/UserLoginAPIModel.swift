//
//  UserLoginAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserLoginAPIModel : AbstractAPIModel
{
    var id: String!
    var userID: String!
    var username: String!
    var password: String!
    var accessLevel: Int!
    
//    override func initialize(json: Dictionary<String, AnyObject>)
//    {
//        self.id = json["id"] as! String
//        self.userID = json["user_id"] as! String
//        self.username = json["username"] as! String
//        self.password = json["password"] as! String
//        self.accessLevel = json["access_level"] as! Int
//    }
}