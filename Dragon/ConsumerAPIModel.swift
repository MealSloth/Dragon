//
//  ConsumerAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

class ConsumerAPIModel: APIModel {
    var id: String!
    var userID: String!
    var locationID: String!
    var favoritePosts: [PostAPIModel]? = []
    var favoriteChefs: [ChefAPIModel]? = []
}
