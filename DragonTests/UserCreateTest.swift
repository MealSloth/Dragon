//
//  UserCreateTest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import Foundation
import XCTest

class UserCreateTest: DragonTest
{
    func testWithEmailAndPassword()
    {
        let readyExpectation = expectation(description: "ready")
        let method = "UserCreateRequest(withEmail:andPassword:)"
        
        let email = "\(String.random(allow: [.Numeric, .AlphaLower, .AlphaUpper, ], length: 20))@mail.com"
        let pass = String.random(allow: [.Numeric, .AlphaLower, .AlphaUpper, .SymbolicUrl, ], length: 32)
        
        UserCreateRequest(withEmail: email, andPassword: pass).request(
            onCompletion: { (result: UserCreateResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.user)
                XCTAssertNotNil(result.userLogin)
                XCTAssertEqual(result.user.email, email)
                XCTAssertEqual(result.userLogin.password, pass)
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                XCTFail("Timed out during \(method) with error \(error)")
                readyExpectation.fulfill()
            }
        )
        
        waitForExpectations(timeout: 10, handler: { (error) -> Void in
            XCTAssertNil(error, "Timed out during \(method) with error \(error)")
        })
    }
}
