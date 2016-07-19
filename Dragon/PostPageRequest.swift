//
//  PostPageRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/17/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class PostPageRequest: APIRequestChimera
{
    init(withPageSize size: Int = 10, usingPostTimestamp time: NSDate)
    {
        super.init(method: "post/page/")
        self.json["page_size"] = size
        self.json["post_time_stamp"] = time.toString()
    }
    
    func request(onCompletion completion: ((post: PostPageResult) -> Void)? = nil, onError: ((error: ErrorType?) -> Void)? = nil)
    {
        self.resultHandler = { (result) -> Void in
            completion?(post: PostPageResult(result: result))
        }
        self.errorHandler = onError
        super.request()
    }
}