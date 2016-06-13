//
//  OrderType.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

enum OrderType: Int, AbstractEnum
{
    case PICKUP = 0
    case DELIVERY = 1
    case DINE_IN = 2
}