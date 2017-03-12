//
//  DragonTests.swift
//  DragonTests
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class DragonTest: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func waitForExpectations(timeout: TimeInterval, duringMethod method: String) {
        super.waitForExpectations(timeout: timeout,
            handler: { (error) -> Void in
                XCTAssertNil(error, "Timeout during \(method) with error \(error)")
            }
        )
    }
    
    func fail(duringMethod method: String, withExpectation expectation: XCTestExpectation, withError error: Error?) {
        XCTFail("Failed during \(method) with error \(error)")
        expectation.fulfill()
    }
    
    func timeout(duringMethod method: String, withError error: Error?) {
        XCTAssertNil(error, "Timed out during \(method) with error \(error)")
    }
}
