//
//  Post.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Post: Model
{
    @NSManaged var id: String!
    @NSManaged var chefID: String!
    @NSManaged var locationID: String!
    @NSManaged var albumID: String!
    @NSManaged var name: String!
    @NSManaged var summary: String!
    @NSManaged var orderCount: NSNumber!
    @NSManaged var capacity: NSNumber!
    @NSManaged var postStatus: NSNumber!
    @NSManaged var postTime: String!
    @NSManaged var expireTime: String!
}
