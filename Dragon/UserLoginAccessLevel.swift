//
//  UserLoginAccessLevel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

enum UserLoginAccessLevel: Int, AbstractEnum
{
    case super_ADMIN = 0
    case chef_ADMIN = 1
    case consumer_ADMIN = 2
    case consumer_CHEF = 3
    case chef = 4
    case consumer = 5
    case trial = 6
}
