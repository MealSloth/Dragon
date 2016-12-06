//
//  ConsumerResult.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class ConsumerResult: APIResult
{
    var consumer: Consumer?
    
    required init(result: [String: Any])
    {
        if let json = result["consumer"] as? [String: Any]
        {
            self.consumer = Consumer.insertOrUpdate(ConsumerAPIModel(json: json))
        }
    }
}
