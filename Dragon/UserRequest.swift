//
//  UserRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserRequest: APIRequest
{
    private var completion: ((UserAPIModel) -> Void)!
    
    init(userID: String, completion: (user: UserAPIModel) -> Void)
    {
        super.init(host: APIHost.APIHostEnum.CHIMERA, method: "user/")
        self.appendParameter("user_id", value: userID)
        self.completion = completion
        self.request()
    }
    
    init(email: String, completion: (user: UserAPIModel) -> Void)
    {
        super.init(host: APIHost.APIHostEnum.CHIMERA, method: "user/")
        self.appendParameter("email", value: email)
        self.completion = completion
        self.request()
    }
    
    private func request()
    {
        self.post(self.handleResult)
    }
    
    func handleResult(result: NSDictionary) -> UserResult
    {
        return UserResult(result: result)
    }
}