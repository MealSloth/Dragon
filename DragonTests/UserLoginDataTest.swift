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

class UserLoginDataTest: DragonTest
{
    func testUserLoginFetch()
    {
        let userLogin = UserLogin.first()
        XCTAssertNotNil(userLogin)
    }
}
