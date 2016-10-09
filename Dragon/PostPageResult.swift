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
    
    required init(result: Dictionary<String, AnyObject>)
    {
        let postsArray = result["posts"] as! [Dictionary<String, AnyObject>]
        for post in postsArray
        {
            if let post = Post.insertOrUpdate(PostAPIModel(json: post))
            {
                Log.debug(post.description)
                self.posts.append(post)
            }
        }
    }
}
