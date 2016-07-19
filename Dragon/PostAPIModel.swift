//
//  PostAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class PostAPIModel: AbstractAPIModel
{
    var id: String!
    var chefID: String!
    var locationID: String!
    var albumID: String!
    var name: String!
    var summary: String!
    var orderCount: Int!
    var capacity: Int!
    var postStatus: Int!
    var postTime: String!
    var expireTime: String!
    
    override func initialize(json: Dictionary<String, AnyObject>, skip: [String])
    {
        let skip: [String] = ["orderCount", "capacity", "postStatus", ]
        self.orderCount = json["order_count"] as! Int
        self.capacity = json["capacity"] as! Int
        self.postStatus = json["post_status"] as! Int
        super.initialize(json, skip: skip)
    }
}