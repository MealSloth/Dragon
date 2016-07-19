//
//  LocationAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class LocationAPIModel: AbstractAPIModel
{
    var id: String!
    var userID: String!
    var purpose: Int!
    var type: Int!
    var addressLineOne: String!
    var addressLineTwo: String?
    var city: String!
    var state: String?
    var country: String?
    var zip: String?
    
    override func initialize(json: Dictionary<String, AnyObject>, skip: [String])
    {
        let skip: [String] = ["purpose", "type", ]
        self.purpose = json["purpose"] as! Int
        self.type = json["type"] as! Int
        super.initialize(json, skip: skip)
    }
}