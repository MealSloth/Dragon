//
//  Consumer.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Consumer: Model
{
    @NSManaged var id: String!
    @NSManaged var userID: String!
    @NSManaged var locationID: String!
    @NSManaged var favoritePosts: [PostAPIModel]?
    @NSManaged var favoriteChefs: [ChefAPIModel]?
}
