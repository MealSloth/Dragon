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
    var userLogin: UserLogin?
    var password: String?
    
    required init(result: [String:Any])
    {
        let model = UserLoginAPIModel(jsonOptional: result["user_login"] as? [String:Any])
        self.password = model?.password
        self.userLogin = UserLogin.insert(model)
    }
}
