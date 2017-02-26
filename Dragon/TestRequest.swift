//
//  TestRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 12/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct TestRequest: APIRequest {
    typealias APIResultType = TestResult
    var method: String = "test/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init() {
        self.json["ayy"] = "lmao"
    }
}
