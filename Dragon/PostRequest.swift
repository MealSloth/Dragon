//
//  PostRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct PostRequest: APIRequest {
    var method: String = "post/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withPostID postID: String?) {
        self.json["post_id"] = postID
    }
}
