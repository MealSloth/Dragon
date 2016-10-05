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
        
        UserRequest(withUserID: "8bbfec5e-c29b-40d6-9918-45911e97134f").request(
            onCompletion: { (result: UserResult) -> Void in
                if let user = result.user
                {
                    XCTAssertNotNil(user.id)
                    Log.debug(user.description)
                    ready.fulfill()
                }
                else
                {
                    XCTFail("User is nil")
                    ready.fulfill()
                }
            },
            onError: { (error) -> Void in
                XCTFail("Error during UserRequest")
                ready.fulfill()
            }
        )
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, "Error during testUserStore: \(error)")
        })
    }
    
    func testUserFetch()
    {
//        let user = User.fromID("8bbfec5e-c29b-40d6-9918-45911e97134f")
//        XCTAssertNotNil(user?.id)
        let users = User.all()
        XCTAssertNotNil(users?[safe: 0]?.id)
    }
    
    func testDeleteAllUsers()
    {
        if let context = Model.context, let users = User.all()
        {
            for user in users
            {
                context.delete(user)
            }
            do
            {
                try context.save()
            }
            catch let error
            {
                Log.error("Failed during testDeleteAllUsers with error: \(error)")
            }
        }
        else
        {
            XCTFail("Failed during testDeleteAllUsers")
        }
    }
}
