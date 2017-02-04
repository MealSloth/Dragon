//
//  UIImageCacheTest.swift
//  Dragon
//
//  Created by Michael Fourre on 1/28/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class UIImageCacheTest: DragonTest {
    func testPutGet() {
        let ready = expectation(description: "ready")
        
        BlobRequest(withUserID: "8bbfec5e-c29b-40d6-9918-45911e97134f").request(
            onCompletion: { (result: BlobResult) -> Void in
                let image = UIImage.from(url: result.blob?.url ?? "")
                let key = String.random()
                UIImageCache.put(image, at: key)
                XCTAssertNotNil(UIImageCache.get(key))
                ready.fulfill()
            },
            onError: { (error) -> Void in
                XCTFail("Failed with error \(error)")
                ready.fulfill()
            }
        )
        
        waitForExpectations(timeout: 10, handler: { (error) -> Void in
            XCTAssertNil(error, "Failed with error \(error)")
        })
    }
}
