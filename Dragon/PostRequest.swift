//
//  PostRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class PostRequest: APIRequest
{
    private var completion: ((PostAPIModel) -> Void)!
    
    init(postID: String, completion: (post: PostAPIModel) -> Void)
    {
        super.init(host: APIHost.APIHostEnum.CHIMERA, method: "post/")
        self.appendParameter("post_id", value: postID)
        self.completion = completion
        self.request()
    }
    
    private func request()
    {
        self.post(self.handleResult)
    }
    
    func handleResult(result: NSDictionary) -> PostResult
    {
        return PostResult(result: result)
    }
}