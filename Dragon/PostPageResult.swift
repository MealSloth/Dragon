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
    var posts: [Post] = []
    
    required init(result: [String:Any])
    {
        if let postsArray = result["posts"] as? [[String:Any]]
        {
            for post in postsArray
            {
                if let post = Post.insert(PostAPIModel(json: post))
                {
                    self.posts.append(post)
                }
            }
        }
    }
}
