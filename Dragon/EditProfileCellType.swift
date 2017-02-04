//
//  EditProfileCellType.swift
//  Dragon
//
//  Created by Michael Fourre on 1/28/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

enum EditProfileCellType: String {
    case photo = "Photo"
    case basic = "Basic"
    case birthday = "Birthday"
    case gender = "Gender"
    
    var name: String {
        return "EditProfile\(self.rawValue)Cell"
    }
}
