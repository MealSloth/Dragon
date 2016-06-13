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
    case SUPER_ADMIN = 0
    case CHEF_ADMIN = 1
    case CONSUMER_ADMIN = 2
    case CONSUMER_CHEF = 3
    case CHEF = 4
    case CONSUMER = 5
    case TRIAL = 6
}