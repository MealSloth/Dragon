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
    var favoritePosts: [PostAPIModel]?
    var favoriteChefs: [ChefAPIModel]?
    
//    override func initialize(json: [String: Any], skip: [String])
//    {
//        let skip: [String] = ["favoritePosts", "favoriteChefs", ]
//        
//        let posts = json["favorite_posts"] as! [[String: Any]]
//        let chefs = json["favorite_chefs"] as! [[String: Any]]
//        
//        for post in posts
//        {
//            favoritePosts.append(PostAPIModel(json: post))
//        }
//        for chef in chefs
//        {
//            favoriteChefs.append(ChefAPIModel(json: chef))
//        }
//        
//        super.initialize(json, skip: skip)
//    }
}
