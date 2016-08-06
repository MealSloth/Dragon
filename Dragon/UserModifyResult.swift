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
    var user: UserAPIModel!
    
    required init(result: Dictionary<String, AnyObject>)
    {
        self.user = UserAPIModel(json: result["user"] as! Dictionary<String, AnyObject>)
    }
}