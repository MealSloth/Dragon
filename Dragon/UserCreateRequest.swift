//
//  UserCreateRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct UserCreateRequest: APIRequest
{
    var method: String = "user/create/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withEmail email: String, andPassword password: String)
    {
        self.initialize(withJSON: [
            "email": email,
            "password": password,
        ])
    }
}
