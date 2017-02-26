//
//  UserLoginTest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class UserLoginTest: DragonTest {
    func testWithUserLoginID() {
        let ready = expectation(description: "ready")
        let method = "UserLoginRequest(withUserLoginID:)"
        
        UserLoginRequest(withUserLoginID: "63dd798f-50d6-40b2-8827-9788a6591dec").request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.userLogin)
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 10, duringMethod: method)
    }
    
    func testWithUserID() {
        let ready = expectation(description: "ready")
        let method = "UserLoginRequest(withUserID:)"
        
        UserLoginRequest(withUserID: "8bbfec5e-c29b-40d6-9918-45911e97134f").request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.userLogin)
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 10, duringMethod: method)
    }
}
