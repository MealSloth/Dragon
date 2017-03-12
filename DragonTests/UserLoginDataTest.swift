//
//  UserLoginDataTest.swift
//  Dragon
//
//  Created by Michael Fourre on 10/11/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import Foundation
import XCTest

class UserLoginDataTest: DragonTest {
    func testUserLoginFetch() {
        let ready = self.expectation(description: "ready")
        let method = "UserLoginRequest(withUserLoginID:)"
        
        UserLoginRequest(withUserLoginID: "63dd798f-50d6-40b2-8827-9788a6591dec").request(
            onCompletion: { (result) -> Void in
                let userLogin = UserLogin.fromID("63dd798f-50d6-40b2-8827-9788a6591dec")
                XCTAssertNotNil(userLogin)
                ready.fulfill()
            },
            onError: { (error) -> Void in
                XCTFail("Error during UserLoginRequest(withUserLoginID:): \(error)")
            }
        )
        
        self.waitForExpectations(timeout: 10, duringMethod: method)
    }
}
