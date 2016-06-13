//
//  UserLoginRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserLoginRequest: APIRequest
{
    private var completion: ((UserLoginAPIModel) -> Void)!
    
    init(userLoginID: String, completion: (userLogin: UserLoginAPIModel) -> Void)
    {
        super.init(host: APIHost.APIHostEnum.CHIMERA, method: "user-login/")
        self.appendParameter("user_login_id", value: userLoginID)
        self.completion = completion
        self.request()
    }
    
    init(userID: String, completion: (userLogin: UserLoginAPIModel) -> Void)
    {
        super.init(host: APIHost.APIHostEnum.CHIMERA, method: "user-login/")
        self.appendParameter("user_id", value: userID)
        self.completion = completion
        self.request()
    }
    
    private func request()
    {
        self.post(self.handleResult)
    }
    
    func handleResult(result: NSDictionary) -> UserResult
    {
        return UserLoginResult(result: result)
    }
}