//
//  UserLoginResult.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserLoginResult: APIResult
{
    var userLogin: UserLoginAPIModel!
    
    init(result: Dictionary<String, AnyObject>)
    {
        self.userLogin = UserLoginAPIModel(json: result["user_login"] as! Dictionary<String, AnyObject>)
    }
}