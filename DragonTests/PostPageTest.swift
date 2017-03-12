//
//  PostPageTest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class PostPageTest: DragonTest {
    func testUsingNothing() {
        let ready = self.expectation(description: "ready")
        let method = "PostPageRequest()"
        
        PostPageRequest().request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.posts)
                if let first = result.posts.first
                {
                    XCTAssertNotNil(first.albumID)
                }
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 10, duringMethod: method)
    }
    
    func testWithPageSize() {
        let ready = self.expectation(description: "ready")
        let method = "PostPageRequest(withPageSize:)"
        
        PostPageRequest(withPageSize: 10).request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.posts)
                if let first = result.posts.first
                {
                    XCTAssertNotNil(first.albumID)
                }
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 10, duringMethod: method)
    }
    
    func testUsingPostTimestamp() {
        let ready = self.expectation(description: "ready")
        let method = "PostPageRequest(usingPostTimestamp:)"
        let date = Date(timeIntervalSince1970: TimeInterval())
        
        PostPageRequest(usingPostTimestamp: date).request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.posts)
                if let first = result.posts.first
                {
                    XCTAssertNotNil(first.albumID)
                }
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 10, duringMethod: method)
    }
    
    func testUsingPostTimestampWithPageSize() {
        let ready = self.expectation(description: "ready")
        let method = "PostPageRequest()"
        let date = Date(timeIntervalSince1970: TimeInterval())
        
        PostPageRequest(withPageSize: 3, usingPostTimestamp: date).request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.posts)
                if let first = result.posts.first
                {
                    XCTAssertNotNil(first.albumID)
                }
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 10, duringMethod: method)
    }
}
