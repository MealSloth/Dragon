//
//  OrderTimeAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class OrderTimeAPIModel: AbstractAPIModel
{
    var id: String!
    var orderID: String!
    var orderStatus: Int!
    var time: String!
    
    override func initialize(json: Dictionary<String, AnyObject>, skip: [String])
    {
        let skip: [String] = ["orderStatus", ]
        self.orderStatus = json["order_status"] as! Int
        super.initialize(json, skip: skip)
    }
}