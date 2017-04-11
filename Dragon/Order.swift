//
//  Order.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Order: Model {
    @NSManaged var id: String!
    @NSManaged var postID: String!
    @NSManaged var consumerID: String!
    @NSManaged var billingID: String!
    @NSManaged var orderSummaryID: String!
    @NSManaged var orderStatus: NSNumber!
    @NSManaged var orderType: NSNumber!
    @NSManaged var orderTime: String!
    @NSManaged var amount: NSNumber!
    
    var status: OrderStatus? {
        get { return OrderStatus(rawValue: self.orderStatus.intValue) }
        set { if let value = newValue?.rawValue { self.orderStatus = NSNumber(value: value) } }
    }
    
    var type: OrderType? {
        get { return OrderType(rawValue: self.orderType.intValue) }
        set { if let value = newValue?.rawValue { self.orderStatus = NSNumber(value: value) } }
    }
}
