//
//  LocationAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class LocationAPIModel: APIModel {
    var id: String!
    var userID: String!
    var purpose: NSNumber!
    var type: NSNumber!
    var addressLineOne: String!
    var addressLineTwo: String?
    var city: String!
    var state: String?
    var country: String?
    var zip: String?
}
