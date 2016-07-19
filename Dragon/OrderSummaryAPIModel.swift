//
//  OrderSummaryAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class OrderSummaryAPIModel: AbstractAPIModel
{
    var id: String!
    var orderID: String!
    var postID: String!
    var orderStatus: Int!
    var orderType: Int!
    var latestTime: String!
    
    override func initialize(json: Dictionary<String, AnyObject>, skip: [String])
    {
        let skip: [String] = ["orderStatus", "orderType", ]
        self.orderStatus = json["order_status"] as! Int
        self.orderType = json["order_type"] as! Int
        super.initialize(json, skip: skip)
    }
}