//
//  PostResult.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class PostResult: APIResult
{
    var post: PostAPIModel!
    
    init(result: NSDictionary)
    {
        self.post = PostAPIModel(json: result["post"] as! Dictionary<String, AnyObject>)
    }
}