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
        let readyExpectation = expectation(description: "ready")
        let method = "UserRequest(withUserID:)"
        
        UserRequest(withUserID: "8bbfec5e-c29b-40d6-9918-45911e97134f").request(
            onCompletion: { (result: UserResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.user)
                XCTAssertEqual(result.user.firstName, "Testing")
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
            }
        )
        
        waitForExpectations(timeout: 20, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
    
    func testWithEmail()
    {
        let readyExpectation = expectation(description: "ready")
        let method = "UserRequest(withEmail:)"
        
        UserRequest(withEmail: "testgryphon@android.com").request(
            onCompletion: { (result: UserResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.user)
                XCTAssertEqual(result.user.firstName, "Testing")
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
            }
        )
        
        waitForExpectations(timeout: 20, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
}
