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
    var orderStatus: NSNumber!
    var orderType: NSNumber!
    var latestTime: String!
}