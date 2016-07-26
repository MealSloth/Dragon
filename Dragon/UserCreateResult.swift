//
//  UserCreateResult.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserCreateResult: APIResult
{
    var user: UserAPIModel!
    var userLogin: UserLoginAPIModel!
    
    init(result: Dictionary<String, AnyObject>)
    {
        self.user = UserAPIModel(json: result["user"] as! Dictionary<String, AnyObject>)
        self.userLogin = UserLoginAPIModel(json: result["user_login"] as! Dictionary<String, AnyObject>)
    }
}