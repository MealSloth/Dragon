//
//  PostDataTest.swift
//  Dragon
//
//  Created by Michael Fourre on 10/1/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import Foundation
import XCTest

class PostDataTest: DragonTest
{
    func testPostStore()
    {
        let ready = expectation(description: "ready")
        
        PostPageRequest().request(
            onCompletion: { (result: PostPageResult) -> Void in
                if let post = result.posts[safe: 0]
                {
                    XCTAssertNotNil(post.id)
                    ready.fulfill()
                }
                else
                {
                    XCTFail("Post at index 0 is nil")
                    ready.fulfill()
                }
            },
            onError: { (error) -> Void in
                XCTFail("Error during PostPageRequest")
                ready.fulfill()
            }
        )
        
        waitForExpectations(timeout: 5, handler: { (error) -> Void in
            XCTAssertNil(error, "Error during testPostStore: \(error)")
        })
    }
    
    func testPostFetch()
    {
        let _ = Post.all()
    }
}
