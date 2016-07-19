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
    
    var resultHandler: ((result: NSDictionary) -> Void)?
    var errorHandler: ((error: ErrorType?) -> Void)?
    
    init(method: String)
    {
        self.host = APIHost.APIHostEnum.CHIMERA
        self.method = method
    }
    
    func request()
    {
        self.post(onCompletion: self.resultHandler, onError: self.errorHandler)
    }
}