//
//  UserTest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import XCTest

class UserTest: DragonTest
{
    func testWithUserID()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "UserRequest(withUserID:)"
        
        UserRequest(withUserID: "8bbfec5e-c29b-40d6-9918-45911e97134f").request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.user)
                XCTAssertEqual(result.user.firstName, "Testing")
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
        })
        
        waitForExpectationsWithTimeout(20, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
    
    func testWithEmail()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "UserRequest(withEmail:)"
        
        UserRequest(withEmail: "testgryphon@android.com").request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.user)
                XCTAssertEqual(result.user.firstName, "Testing")
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
        })
        
        waitForExpectationsWithTimeout(20, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
}