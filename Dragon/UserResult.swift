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
    var user: UserAPIModel!
    
    init(result: NSDictionary)
    {
        self.user = UserAPIModel(json: result["user"] as! Dictionary<String, AnyObject>)
    }
}