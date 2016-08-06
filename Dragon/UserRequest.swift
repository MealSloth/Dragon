//
//  UserRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserRequest: APIRequestChimera
{
    init(withUserID userID: String)
    {
        super.init(method: "user/")
        self.json["user_id"] = userID
    }
    
    init(withEmail email: String)
    {
        super.init(method: "user/")
        self.json["email"] = email
    }
}