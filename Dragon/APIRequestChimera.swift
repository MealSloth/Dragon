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
    var json: [String:Any] = [:]
    var method: String
    var host: APIHost
    
    var resultHandler: ((_ result: [String:Any]) -> Void)?
    var errorHandler: ((_ error: Error?) -> Void)?
    
    init(method: String)
    {
        self.host = .chimera
        //Remove prepending slashes if applicable
        self.method = method.characters.first == "/" ? String(method.characters.dropFirst()) : method
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
