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
    private func postRequest(completion: ((PostPageResult, XCTestExpectation) -> Void)?)
    {
        let ready = expectation(description: "ready")
        let method = "PostPageRequest()"
        
        PostPageRequest().request(
            onCompletion: { (result: PostPageResult) -> Void in
                completion?(result, ready)
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        waitForExpectations(timeout: 5, duringMethod: method)
    }
    
    func testPostStore()
    {
        self.postRequest(completion: { (result: PostPageResult, ready: XCTestExpectation) -> Void in
            XCTAssertNotNil(result.posts[safe: 0])
            XCTAssertNotNil(result.posts[safe: 0]?.id)
        })
    }
    
    func testPostFetch()
    {
        self.postRequest(completion: { (result: PostPageResult, ready: XCTestExpectation) -> Void in
            let posts = Post.all()
            XCTAssertNotNil(posts?[safe: 0])
        })
    }
    
    func testPostUpdate()
    {
        self.postRequest(completion: { (result: PostPageResult, ready: XCTestExpectation) -> Void in
            /**
             ** For anyone who has to look at this: I'm sorry.
             ** Apple is slow and can't figure out how to use
             ** native Swift types with CoreData and reflection.
             **/
            if let post = Post.first()
            {
                let capacity: Int = post.capacity as Int
                post.capacity = capacity + 1 as NSNumber
                post.save()
                XCTAssert(post.capacity == (capacity + 1 as NSNumber))
                if let samePost = Post.first()
                {
                    XCTAssert(samePost.capacity == (capacity + 1 as NSNumber))
                }
            }
        })
    }
    
    func testDeleteAllPosts()
    {
        self.postRequest(completion: { (result: PostPageResult, ready: XCTestExpectation) -> Void in
            Post.deleteAll()
            XCTAssertNil(Post.first())
        })
    }
}
