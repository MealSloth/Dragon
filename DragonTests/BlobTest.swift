//
//  BlobTest.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import XCTest

class BlobTest: DragonTest
{
    func testWithBlobID()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "BlobRequest(withBlobID:)"
        
        BlobRequest(withBlobID: "c1dacec6-9156-4cd7-a670-ef06d9c4a73a").request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.blob)
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                XCTFail("Failed during \(method) with error \(error)")
                readyExpectation.fulfill()
            }
        )
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            XCTAssertNil(error, "Timeout during \(method) with error \(error)")
        })
    }
    
    func testWithAlbumID()
    {
        let readyExpectation = expectationWithDescription("ready")
        let method = "BlobRequest(withAlbumID:)"
        
        BlobRequest(withAlbumID: "9d94bffa-c279-498b-a790-aced6c5aec98").request(
            onCompletion: { (result) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.blobs)
                readyExpectation.fulfill()
            },
            onError: { (error) -> Void in
                XCTFail("Failed during \(method) with error \(error)")
                readyExpectation.fulfill()
            }
        )
        
        waitForExpectationsWithTimeout(10, handler: { (error) -> Void in
            XCTAssertNil(error, "Timeout during \(method) with error \(error)")
        })
    }
}