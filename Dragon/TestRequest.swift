//
//  TestRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 12/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class TestRequest: APIRequestChimera
{
    init()
    {
        super.init(method: "test/")
        self.json["ayy"] = "lmao"
    }
}
