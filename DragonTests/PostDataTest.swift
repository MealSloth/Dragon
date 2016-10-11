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
        let posts = Post.all()
        XCTAssertNotNil(posts?[safe: 0])
    }
    
    func testPostUpdate()
    {
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
    }
    
    func testDeleteAllPosts()
    {
        Post.deleteAll()
    }
}
