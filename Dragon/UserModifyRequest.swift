//
//  UserModifyRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 7/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct UserModifyRequest: APIRequest
{
    var method: String = "user/modify/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withUserID userID: String?, firstName: String?, lastName: String?, gender: UserGender?, dateOfBirth: Date?, phoneNumber: String?)
    {
        self.initialize(withJSON: [
            "user_id": userID ?? "",
            "first_name": firstName ?? "",
            "last_name": lastName ?? "",
            "gender": gender?.rawValue ?? -1,
            "date_of_birth": dateOfBirth?.toString() ?? "",
            "phone_number": phoneNumber ?? "",
        ])
    }
}
