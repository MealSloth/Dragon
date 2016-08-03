//
//  PostTest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/18/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import XCTest

class PostTest: DragonTest
{
    func testWithPostID()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "PostRequest(withPostID:)"
        
        PostRequest(withPostID: "de93088f-8fd4-4e35-8de1-d71292fdb047").request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.post)
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