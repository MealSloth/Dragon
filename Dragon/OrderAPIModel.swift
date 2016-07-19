//
//  OrderAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class OrderAPIModel: AbstractAPIModel
{
    var id: String!
    var postID: String!
    var chefID: String!
    var consumerID: String!
    var locationID: String!
    var billingID: String!
    var orderTimeID: String!
    var orderSummaryID: String!
    var orderStatus: Int!
    var orderType: Int!
    var amount: Int!
    
    override func initialize(json: Dictionary<String, AnyObject>, skip: [String])
    {
        let skip: [String] = ["orderStatus", "orderType", "amount", ]
        self.orderStatus = json["order_status"] as! Int
        self.orderType = json["order_type"] as! Int
        self.amount = json["order_type"] as! Int
        super.initialize(json, skip: skip)
    }
}