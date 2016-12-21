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
    
    required init(result: [String:Any])
    {
        self.user = User.insert(UserAPIModel(jsonOptional: result["user"] as? [String:Any]))
        let model = UserLoginAPIModel(jsonOptional: result["user_login"] as? [String:Any])
        self.userLogin = UserLogin.insert(model)
        self.password = model?.password
    }
}
