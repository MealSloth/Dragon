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
    var method: String = ""
    var host: APIHost = .chimera
    
    var resultHandler: ((_ result: Dictionary<String, AnyObject>) -> Void)?
    var errorHandler: ((_ error: Error?) -> Void)?
    
    init(method: String)
    {
        self.host = .chimera
        self.method = (method.substring(to: method.characters.index(method.startIndex, offsetBy: 1)) == "/") ? method.substring(from: method.characters.index(method.startIndex, offsetBy: 1)) : method
    }
    
    func request<T: APIResult>(onCompletion completion: ((_ result: T) -> Void)? = nil, onError: ((_ error: Error?) -> Void)? = nil)
    {
        let resultHandler = { (result) -> Void in
            completion?(T(result: result))
        }
        let errorHandler = onError
        self.post(onCompletion: resultHandler, onError: errorHandler)
    }
}
