//
//  UserModifyTest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class UserModifyTest: DragonTest
{
    func testWithUserIDFirstNameLastNameGenderDateOfBirthPhoneNumber()
    {
        let readyExpectation = expectation(description: "ready")
        let method = "UserModifyRequest(withUserID:firstName:lastName:gender:dateOfBirth:phoneNumber:)"
        let dob = Date(timeIntervalSince1970: TimeInterval())
        
        let id = "8bbfec5e-c29b-40d6-9918-45911e97134f"
        let first = "Testing"
        let last = "Gryphon"
        
        UserModifyRequest(withUserID: id, firstName: "FirstName", lastName: "LastName", gender: .other, dateOfBirth: dob, phoneNumber: "+001_1234567890").request(
            onCompletion: { (result: UserModifyResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.user)
                XCTAssertNotEqual(result.user.firstName, first)
                XCTAssertNotEqual(result.user.lastName, last)
                UserModifyRequest(withUserID: id, firstName: first, lastName: last, gender: .male, dateOfBirth: dob, phoneNumber: "+001_1234567890").request(
                    onCompletion: { (result: UserModifyResult) -> Void in
                        XCTAssertNotNil(result)
                        XCTAssertNotNil(result.user)
                        XCTAssertEqual(result.user.firstName, first)
                        XCTAssertEqual(result.user.lastName, last)
                        readyExpectation.fulfill()
                    },
                    onError: { (error) -> Void in
                        XCTFail("Failed during \(method) with error \(error)")
                        readyExpectation.fulfill()
                    }
                )
            },
            onError: { (error) -> Void in
                XCTFail("Failed during \(method) with error \(error)")
                readyExpectation.fulfill()
            }
        )
        
        waitForExpectations(timeout: 10, handler: { (error) -> Void in
            XCTAssertNil(error, "Timed out during \(method) with error \(error)")
        })
    }
}
