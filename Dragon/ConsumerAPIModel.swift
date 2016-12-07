//
//  ConsumerAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class ConsumerAPIModel: APIModel
{
    var id: String!
    var userID: String!
    var locationID: String!
    var favoritePosts: [PostAPIModel] = []
    var favoriteChefs: [ChefAPIModel] = []
    
    override func initialize(_ json: [String: Any], skip: [String])
    {
        let skip = ["favoritePosts", "favoriteChefs", ]
        
        if let posts = json["favorite_posts"] as? [Any]
        {
            for post in posts
            {
                if let dict = post as? [String: Any]
                {
                    favoritePosts.append(PostAPIModel(json: dict))
                }
            }
        }
        
        if let chefs = json["favorite_chefs"] as? [Any]
        {
            for chef in chefs
            {
                if let dict = chef as? [String: Any]
                {
                    favoriteChefs.append(ChefAPIModel(json: dict))
                }
            }
        }
        
        super.initialize(json, skip: skip)
    }
}
