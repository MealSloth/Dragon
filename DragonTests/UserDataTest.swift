//
//  UserDataTest.swift
//  Dragon
//
//  Created by Michael Fourre on 10/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import Foundation
import XCTest

class UserDataTest: DragonTest
{
    func testUserStore()
    {
        let ready = expectation(description: "ready")
        let method = "UserRequest(withUserID:)"
        
        UserRequest(withUserID: "8bbfec5e-c29b-40d6-9918-45911e97134f").request(
            onCompletion: { (result: UserResult) -> Void in
                if let user = result.user
                {
                    XCTAssertNotNil(user.id)
                    ready.fulfill()
                }
                else
                {
                    XCTFail("User is nil")
                    ready.fulfill()
                }
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 5, duringMethod: method)
    }
    
    func testFromID()
    {
        let user = User.fromID("8bbfec5e-c29b-40d6-9918-45911e97134f")
        XCTAssertNotNil(user)
    }
    
    func testUserFetch()
    {
        let users = User.all()
        XCTAssertNotNil(users?[safe: 0])
    }
    
    func testDeleteAllUsers()
    {
        User.deleteAll()
    }
    
    func testDeleteID()
    {
        User.delete(withID: "8bbfec5e-c29b-40d6-9918-45911e97134f")
    }
}
