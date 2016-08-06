//
//  UserCreateRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserCreateRequest: APIRequestChimera
{
    init(withEmail email: String, andPassword password: String)
    {
        super.init(method: "user/create/")
        self.json["email"] = email
        self.json["password"] = password
    }
}