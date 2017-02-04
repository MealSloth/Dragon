//
//  EqualityTest.swift
//  Dragon
//
//  Created by Michael Fourre on 12/25/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon
import XCTest

class EqualityTest: DragonTest {
    func testTestCompare() {
        let a = TestAPIModel(json: [
            "test_int": 2,
            "test_string": "test",
            "test_int_list": [3, 4, ],
            "test_string_list": ["test", "test2", "test3", ],
            "test_post_model": [
                "id": "ASDF",
            ],
            "test_consumer_model": [
                "id": "ASDF",
            ],
            "test_user_model_list": [
                [
                    "id": "asdf"
                ],
                [
                    "id": "ghjkl"
                ],
            ],
            "test_consumer_model_list": [
                [
                    "id": "asdf",
                    ],
                [
                    "id": "ghjkl",
                    ],
            ],
            ])
        let b = TestAPIModel(json: [
            "test_int": 2,
            "test_string": "test",
            "test_int_list": [3, 4, ],
            "test_string_list": ["test", "test2", "test3", ],
            "test_post_model": [
                "id": "ASDF",
            ],
            "test_consumer_model": [
                "id": "ASDF",
            ],
            "test_user_model_list": [
                [
                    "id": "asdf"
                ],
                [
                    "id": "ghjkl"
                ],
            ],
            "test_consumer_model_list": [
                [
                    "id": "asdf",
                    ],
                [
                    "id": "ghjkl",
                    ],
            ],
            ])
        
        assertEqual(a, b)
        
        a.testString = "FDSA"
        assertUnequal(a, b)
        b.testString = "FDSA"
        assertEqual(a, b)
        
        a.testConsumerModel = ConsumerAPIModel(json: ["id": "FDSA", ])
        assertUnequal(a, b)
        b.testConsumerModel = ConsumerAPIModel(json: ["id": "FDSA", ])
        assertEqual(a, b)
        
        a.testUserModelList = [UserAPIModel(json: ["id": "fdsa", ]), UserAPIModel(json: ["id": "ghjkl", ]), ]
        assertUnequal(a, b)
        b.testUserModelList = [UserAPIModel(json: ["id": "fdsa", ]), UserAPIModel(json: ["id": "ghjkl", ]), ]
        assertEqual(a, b)
    }
    
    func assertEqual(_ a: APIModel, _ b: APIModel) {
        XCTAssertTrue(a == b)
        XCTAssertTrue(b == a)
        XCTAssertFalse(a != b)
        XCTAssertFalse(b != a)
    }
    
    func assertUnequal(_ a: APIModel, _ b: APIModel) {
        XCTAssertFalse(a == b)
        XCTAssertFalse(b == a)
        XCTAssertTrue(a != b)
        XCTAssertTrue(b != a)
    }
}
