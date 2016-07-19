//
//  UserRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserRequest: APIRequestChimera
{
    init(withUserID userID: String)
    {
        super.init(method: "user/")
        self.json["user_id"] = userID
    }
    
    init(withEmail email: String)
    {
        super.init(method: "user/")
        self.json["email"] = email
    }
    
    func request(onCompletion completion: ((result: UserResult) -> Void)? = nil, onError: ((error: ErrorType?) -> Void)? = nil)
    {
        self.resultHandler = { (result) -> Void in
            completion?(result: UserResult(result: result))
        }
        self.errorHandler = onError
        super.request()
    }
}