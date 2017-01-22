//
//  UserLoginRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct UserLoginRequest: APIRequest
{
    var method: String = "user/login/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withUserLoginID userLoginID: String?)
    {
        self.initialize(withJSON: [
            "user_login_id": userLoginID ?? "",
        ])
    }
    
    init(withUserID userID: String?)
    {
        self.initialize(withJSON: [
            "user_id": userID ?? "",
        ])
    }
}
