//
//  PostPageResult.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct PostPageResult: APIResult {
    var posts: [Post] = []
    
    init(result: [String:Any]) {
        if let postsArray = result["posts"] as? [[String:Any]] {
            postsArray.forEach({ if let post = Post.insert(PostAPIModel(json: $0)) { self.posts.append(post) } })
        }
    }
}
