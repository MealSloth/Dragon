//
//  UserLoginTest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class UserLoginTest: DragonTest
{
    func testWithUserLoginID()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "UserLoginRequest(withUserLoginID:)"
        
        UserLoginRequest(withUserLoginID: "63dd798f-50d6-40b2-8827-9788a6591dec").request(
            onCompletion: { (result: UserLoginResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.userLogin)
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
    
    func testWithUserID()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "UserLoginRequest(withUserID:)"
        
        UserLoginRequest(withUserID: "8bbfec5e-c29b-40d6-9918-45911e97134f").request(
            onCompletion: { (result: UserLoginResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.userLogin)
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
