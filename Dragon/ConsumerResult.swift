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
    var consumer: ConsumerAPIModel!
    
    init(result: Dictionary<String, AnyObject>)
    {
        self.consumer = ConsumerAPIModel(json: result["consumer"] as! Dictionary<String, AnyObject>)
    }
}