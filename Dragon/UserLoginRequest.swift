//
//  UserLoginRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserLoginRequest: APIRequestChimera
{
    fileprivate var completion: ((UserLoginResult) -> Void)?
    
    init(withUserLoginID userLoginID: String?)
    {
        super.init(method: "user-login/")
        self.json["user_login_id"] = userLoginID as AnyObject?
    }
    
    init(withUserID userID: String?)
    {
        super.init(method: "user-login/")
        self.json["user_id"] = userID as AnyObject?
    }
}
