//
//  UserLoginResult.swift
//  Dragon
//
//  Created by Michael Fourre on 6/12/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct UserLoginResult: APIResult {
    var userLogin: UserLogin?
    private var password: String?
    
    init(result: [String:Any]) {
        let model = UserLoginAPIModel(jsonOptional: result["user_login"] as? [String:Any])
        self.password = model?.password
        self.userLogin = UserLogin.insert(model)
    }
    
    func valid(username: String?, password: String?) -> Bool {
        let emailValid = self.userLogin?.user?.email == username
        let usernameValid = self.userLogin?.username == username
        let passwordValid = self.password == password
        return passwordValid && (emailValid || usernameValid)
    }
}
