//
//  RandomStringAllow.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

enum RandomStringAllow: String
{
    case Numeric = "1234567890"
    case AlphaLower = "abcdefghijklmnopqrstuvwxyz"
    case AlphaUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    case SymbolicUrl = "$-_.+!*'(),"
    case SymbolicStandard = "~`@#%^&=[];/{}|:<>?'"
}