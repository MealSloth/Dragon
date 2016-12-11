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
    
    required init(result: [String: Any])
    {
        if let json = result["user"] as? [String: Any]
        {
            self.user = User.insert(UserAPIModel(json: json))
        }
        if let json = result["user_login"] as? [String: Any]
        {
            let model = UserLoginAPIModel(json: json)
            self.userLogin = UserLogin.insert(model)
            self.password = model.password
        }
    }
}
