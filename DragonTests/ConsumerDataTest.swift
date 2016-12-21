//
//  ConsumerDataTest.swift
//  Dragon
//
//  Created by Michael Fourre on 12/20/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon

class ConsumerDataTest: DragonTest
{
    func testTest()
    {
        if let consumers = Consumer.all(), let count = Consumer.all()?.count
        {
            Log.debug("# consumers: \(count)")
            for consumer in consumers
            {
                Log.debug("\(consumer)")
            }
        }
    }
}
