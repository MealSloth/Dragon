//
//  UserTest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class UserTest: DragonTest
{
    func testWithUserID()
    {
        let ready = expectation(description: "ready")
        let method = "UserRequest(withUserID:)"
        
        UserRequest(withUserID: "8bbfec5e-c29b-40d6-9918-45911e97134f").request(
            onCompletion: { (result: UserResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.user)
                XCTAssertEqual(result.user?.firstName, "Testing")
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 10, duringMethod: method)
    }
    
    func testWithEmail()
    {
        let ready = expectation(description: "ready")
        let method = "UserRequest(withEmail:)"
        
        UserRequest(withEmail: "testgryphon@android.com").request(
            onCompletion: { (result: UserResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.user)
                XCTAssertEqual(result.user?.firstName, "Testing")
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 10, duringMethod: method)
    }
}
