//
//  PostAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class PostAPIModel: AbstractAPIModel
{
    var id: String!
    var chefID: String!
    var locationID: String!
    var albumID: String!
    var name: String!
    var summary: String!
    var orderCount: NSNumber!
    var capacity: NSNumber!
    var postStatus: NSNumber!
    var postTime: String!
    var expireTime: String!
}