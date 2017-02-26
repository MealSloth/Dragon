//
//  UserCreateRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct UserCreateRequest: APIRequest {
    typealias APIResultType = UserCreateResult
    var method: String = "user/create/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withEmail email: String, andPassword password: String) {
        self.json["email"] = email
        self.json["password"] = password
    }
}
