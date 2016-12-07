//
//  OrderAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class OrderAPIModel: APIModel
{
    var id: String!
    var postID: String!
    var consumerID: String!
    var billingID: String!
    var orderSummaryID: String!
    var orderStatus: NSNumber!
    var orderType: NSNumber!
    var orderTime: String!
    var amount: NSNumber!
}
