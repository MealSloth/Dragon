//
//  ConsumerResult.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct ConsumerResult: APIResult
{
    var consumer: Consumer?
    
    init(result: [String:Any])
    {
        self.consumer = Consumer.insert(ConsumerAPIModel(jsonOptional: result["consumer"] as? [String:Any]))
    }
}
