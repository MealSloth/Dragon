//
//  ConsumerRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class ConsumerRequest: APIRequestChimera
{
    init(withConsumerID consumerID: String)
    {
        super.init(method: "consumer/")
        self.json["consumer_id"] = consumerID
    }
}