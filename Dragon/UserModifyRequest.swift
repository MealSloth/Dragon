//
//  UserModifyRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class UserModifyRequest: APIRequestChimera
{
    init(withUserID userID: String, firstName: String?, lastName: String?, gender: UserGender?, dateOfBirth: Date?, phoneNumber: String?)
    {
        super.init(method: "user/modify/")
        self.json["user_id"] = userID
        self.json["first_name"] = firstName
        self.json["last_name"] = lastName
        self.json["gender"] = gender?.rawValue
        self.json["date_of_birth"] = dateOfBirth?.toString()
        self.json["phone_number"] = phoneNumber
    }
}
