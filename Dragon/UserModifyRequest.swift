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
        self.json["user_id"] = userID as AnyObject?
        self.json["first_name"] = firstName as AnyObject?
        self.json["last_name"] = lastName as AnyObject?
        self.json["gender"] = gender?.rawValue as AnyObject?
        self.json["date_of_birth"] = dateOfBirth?.toString() as AnyObject?
        self.json["phone_number"] = phoneNumber as AnyObject?
    }
}
