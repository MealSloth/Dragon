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
    var user: User?
    var userLogin: UserLogin?
    var password: String?
    
    required init(result: Dictionary<String, AnyObject>)
    {
        if let json = result["user"] as? Dictionary<String, AnyObject>
        {
            self.user = User.insertOrUpdate(UserAPIModel(json: json))
        }
        if let json = result["user_login"] as? Dictionary<String, AnyObject>
        {
            let model = UserLoginAPIModel(json: json)
            self.userLogin = UserLogin.insertOrUpdate(model)
            self.password = model.password
        }
    }
}
