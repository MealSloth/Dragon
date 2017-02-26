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

class UserDataTest: DragonTest {
    let id = "8bbfec5e-c29b-40d6-9918-45911e97134f"
    
    private func userRequest(completion: ((UserResult, XCTestExpectation) -> Void)?) {
        let ready = expectation(description: "ready")
        let method = "UserRequest(withUserID:)"
        
        UserRequest(withUserID: self.id).request(
            onCompletion: { (result) -> Void in
                completion?(result, ready)
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 5, duringMethod: method)
    }
    
    func testUserStore() {
        self.userRequest(completion: { (result: UserResult, ready: XCTestExpectation) -> Void in
            XCTAssertNotNil(result.user)
            XCTAssertNotNil(result.user?.id)
        })
    }
    
    func testFromID() {
        userRequest(completion: { (result: UserResult, ready: XCTestExpectation) -> Void in
            let user = User.fromID(self.id)
            XCTAssertNotNil(user)
        })
    }
    
    func testUserFetch() {
        userRequest(completion: { (result: UserResult, ready: XCTestExpectation) -> Void in
            let users = User.all()
            XCTAssertNotNil(users?.first)
        })
    }
    
    func testDeleteAllUsers() {
        userRequest(completion: { (result: UserResult, ready: XCTestExpectation) -> Void in
            let user = User.fromID(self.id)
            XCTAssertNotNil(user)
            User.deleteAll()
            XCTAssertNil(User.first())
        })
    }
    
    func testDeleteID() {
        userRequest(completion: { (result: UserResult, ready: XCTestExpectation) -> Void in
            User.delete(withID: self.id)
            XCTAssertNil(User.fromID(self.id))
        })
    }
}
