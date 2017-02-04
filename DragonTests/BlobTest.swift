//
//  BlobTest.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class BlobTest: DragonTest {
    func testWithBlobID() {
        let ready = expectation(description: "ready")
        let method = "BlobRequest(withBlobID:)"
        
        BlobRequest(withBlobID: "c1dacec6-9156-4cd7-a670-ef06d9c4a73a").request(
            onCompletion: { (result: BlobResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.blob)
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        self.waitForExpectations(timeout: 10, duringMethod: method)
    }
    
    func testWithAlbumID() {
        let ready = expectation(description: "ready")
        let method = "BlobRequest(withAlbumID:)"
        
        BlobRequest(withAlbumID: "9d94bffa-c279-498b-a790-aced6c5aec98").request(
            onCompletion: { (result: BlobResult) -> Void in
                XCTAssertNotNil(result)
                XCTAssertNotNil(result.blobs)
                ready.fulfill()
            },
            onError: { (error) -> Void in
                self.fail(duringMethod: method, withExpectation: ready, withError: error)
            }
        )
        
        self.waitForExpectations(timeout: 10, duringMethod: method)
    }
}
