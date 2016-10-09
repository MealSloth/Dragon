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
                    Log.debug(post.description)
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
        for post in posts!
        {
            Log.debug(post.description)
        }
        XCTAssertNotNil(posts?[safe: 0])
    }
    
    func testDeleteAllPosts()
    {
        if let context = Model.context, let posts = Post.all()
        {
            for post in posts
            {
                context.delete(post)
            }
            do
            {
                try context.save()
            }
            catch let error
            {
                XCTAssertNil(error, "Failed during testDeleteAllPosts with error: \(error)")
            }
        }
        else
        {
            XCTFail("Failed during testDeleteAllPosts")
        }
    }
    
    func testRandom()
    {
        let posts = Post.all()
        for post in posts!
        {
            Log.debug(post.description)
        }
    }
}
