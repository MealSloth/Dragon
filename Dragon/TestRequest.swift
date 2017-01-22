//
//  TestRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 12/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct TestRequest: APIRequest
{
    var method: String = "test/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init()
    {
        self.json["ayy"] = "lmao"
    }
}
