//
//  APIRequestChimera.swift
//  Dragon
//
//  Created by Michael Fourre on 7/18/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class APIRequestChimera: APIRequest
{
    var json: Dictionary<String, AnyObject> = [:]
    var host: APIHost.APIHostEnum!
    var method: String!
    
    var resultHandler: ((result: Dictionary<String, AnyObject>) -> Void)?
    var errorHandler: ((error: NSError?) -> Void)?
    
    init(method: String)
    {
        self.host = APIHost.APIHostEnum.CHIMERA
        self.method = (method.substringToIndex(method.startIndex.advancedBy(1)) == "/") ? method.substringFromIndex(method.startIndex.advancedBy(1)) : method
    }
    
    func request()
    {
        self.post(onCompletion: self.resultHandler, onError: self.errorHandler)
    }
}