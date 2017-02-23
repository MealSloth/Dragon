//
//  RandomStringAllow.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

enum RandomStringAllow: String, Enumerable {
    case numeric = "1234567890"
    case alphaLower = "abcdefghijklmnopqrstuvwxyz"
    case alphaUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    case symbolicUrl = "$-_.+!*'(),"
    case symbolicStandard = "~`@#%^&=[];/{}|:<>?'"
}
