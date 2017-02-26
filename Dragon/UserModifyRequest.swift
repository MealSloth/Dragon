//
//  UserModifyRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct UserModifyRequest: APIRequest {
    typealias APIResultType = UserModifyResult
    var method: String = "user/modify/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withUserID userID: String?, firstName: String?, lastName: String?, gender: UserGender?, dateOfBirth: Date?, phoneNumber: String?) {
        self.json["user_id"] = userID
        self.json["first_name"] = firstName
        self.json["last_name"] = lastName
        self.json["gender"] = gender?.rawValue
        self.json["date_of_birth"] = dateOfBirth?.string
        self.json["phone_number"] = phoneNumber
    }
}
