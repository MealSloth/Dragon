//
//  Order.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Order: Model
{
    @NSManaged var id: String!
    @NSManaged var postID: String!
    @NSManaged var chefID: String!
    @NSManaged var consumerID: String!
    @NSManaged var locationID: String!
    @NSManaged var billingID: String!
    @NSManaged var orderTimeID: String!
    @NSManaged var orderSummaryID: String!
    @NSManaged var orderStatus: NSNumber!
    @NSManaged var orderType: NSNumber!
    @NSManaged var amount: NSNumber!
}