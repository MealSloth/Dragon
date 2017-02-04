//
//  UserLoginRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct UserLoginRequest: APIRequest {
    var method: String = "user-login/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withUserLoginID userLoginID: String?) {
        self.json["user_login_id"] = userLoginID
    }
    
    init(withUserID userID: String?) {
        self.json["user_id"] = userID
    }
}
