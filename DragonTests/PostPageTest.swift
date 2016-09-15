//
//  PostPageTest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/19/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class PostPageTest: DragonTest
{
    func testUsingNothing()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "PostPageRequest()"
        
        PostPageRequest().request(
            onCompletion: { (result: PostPageResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.posts)
                if let first = result.posts.first
                {
                    XCTAssertNotNil(first.albumID)
                }
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
            }
        )
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
    
    func testWithPageSize()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "PostPageRequest(withPageSize:)"
        
        PostPageRequest(withPageSize: 10).request(
            onCompletion: { (result: PostPageResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.posts)
                if let first = result.posts.first
                {
                    XCTAssertNotNil(first.albumID)
                }
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
            }
        )
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
    
    func testUsingPostTimestamp()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "PostPageRequest(usingPostTimestamp:)"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval())
        
        PostPageRequest(usingPostTimestamp: date).request(
            onCompletion: { (result: PostPageResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.posts)
                if let first = result.posts.first
                {
                    XCTAssertNotNil(first.albumID)
                }
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
            }
        )
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
    
    func testUsingPostTimestampWithPageSize()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "PostPageRequest()"
        let date = NSDate(timeIntervalSince1970: NSTimeInterval())
        
        PostPageRequest(withPageSize: 3, usingPostTimestamp: date).request(
            onCompletion: { (result: PostPageResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.posts)
                if let first = result.posts.first
                {
                    XCTAssertNotNil(first.albumID)
                }
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: readyExpectation, withError: error)
            }
        )
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            self.timeout(duringMethod: method, withError: error)
        })
    }
}
