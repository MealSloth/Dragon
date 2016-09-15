//
//  ConsumerTest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class ConsumerTest: DragonTest
{
    func testWithConsumerID()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "ConsumerRequest(withConsumerId:)"
        
        ConsumerRequest(withConsumerID: "d25a27ba-1e43-49ff-92b5-37285c4af962").request(
            onCompletion: { (result: ConsumerResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.consumer)
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
            }
        )
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
}
