//
//  OrderTime.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class OrderTime: Model
{
    @NSManaged var id: String!
    @NSManaged var orderID: String!
    @NSManaged var orderStatus: NSNumber!
    @NSManaged var time: NSDate!
}
