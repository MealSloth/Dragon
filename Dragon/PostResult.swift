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
    var post: Post?
    
    required init(result: Dictionary<String, AnyObject>)
    {
        if let json = result["post"] as? Dictionary<String, AnyObject>
        {
            self.post = Post.insertOrUpdate(PostAPIModel(json: json))
        }
    }
}
