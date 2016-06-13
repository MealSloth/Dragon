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
    case PENDING = 0
    case RECEIVED = 1
    case PROGRESS = 2
    case COMPLETED = 3
    case SHIPPED = 4
    case DELIVERED = 5
    case DISPUTED = 6
    case CANCELLED = 7
}