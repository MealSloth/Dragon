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
    
    required init(result: [String: Any])
    {
        self.post = Post.insert(PostAPIModel(jsonOptional: result["post"] as? [String: Any]))
    }
}
