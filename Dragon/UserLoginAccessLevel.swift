//
//  UserLoginAccessLevel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

enum UserLoginAccessLevel: Int, AbstractEnum {
    case superAdmin = 0
    case chefAdmin = 1
    case consumerAdmin = 2
    case consumerChef = 3
    case chef = 4
    case consumer = 5
    case trial = 6
}
