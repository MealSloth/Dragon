//
//  UserRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct UserRequest: APIRequest {
    typealias APIResultType = UserResult
    var method: String = "user/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withUserID userID: String?) {
        self.json["user_id"] = userID
    }
    
    init(withEmail email: String?) {
        self.json["email"] = email
    }
}
