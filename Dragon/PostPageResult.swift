//
//  PostPageResult.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class PostPageResult: APIResult
{
    var posts: [PostAPIModel] = []
    
    init(result: NSDictionary)
    {
        let postsDict = result["posts"] as! [Dictionary<String, AnyObject>]
        for post in postsDict
        {
            self.posts.append(PostAPIModel(json: post))
        }
    }
}