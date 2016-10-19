//
//  DragonUITests.swift
//  DragonUITests
//
//  Created by Michael Fourre on 9/14/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import XCTest

class DragonUITests: XCTestCase
{
    override func setUp()
    {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
}
