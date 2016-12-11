//
//  UserModifyResult.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserModifyResult: APIResult
{
    var user: User?
    
    required init(result: [String: Any])
    {
        if let json = result["user"] as? [String: Any]
        {
            self.user = User.insert(UserAPIModel(json: json))
        }
    }
}
