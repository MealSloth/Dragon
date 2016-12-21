//
//  UserResult.swift
//  Dragon
//
//  Created by Michael Fourre on 5/4/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserResult: APIResult
{
    var user: User?
    
    required init(result: [String:Any])
    {
        self.user = User.insert(UserAPIModel(jsonOptional: result["user"] as? [String:Any]))
    }
}
