//
//  OrderStatus.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

enum OrderStatus: Int, AbstractEnum
{
    case pending = 0
    case received = 1
    case progress = 2
    case completed = 3
    case shipped = 4
    case delivered = 5
    case disputed = 6
    case cancelled = 7
}
