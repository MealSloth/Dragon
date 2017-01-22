//
//  ConsumerRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct ConsumerRequest: APIRequest
{
    var method: String = "consumer/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withConsumerID consumerID: String?)
    {
        self.initialize(withJSON: [
            "consumer_id": consumerID ?? "",
        ])
    }
}
