//
//  PostRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class PostRequest: APIRequestChimera
{
    init(withPostID postID: String)
    {
        super.init(method: "post/")
        self.json["post_id"] = postID as AnyObject?
    }
}
