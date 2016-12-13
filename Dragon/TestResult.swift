//
//  TestResult.swift
//  Dragon
//
//  Created by Michael Fourre on 12/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class TestResult: APIResult
{
    var test: TestAPIModel?
    
    required init(result: [String: Any])
    {
        self.test = TestAPIModel(jsonOptional: result["test"] as? [String: Any])
    }
}
