//
//  ConsumerAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class ConsumerAPIModel: AbstractAPIModel
{
    var id: String!
    var userID: String!
    var locationID: String!
    var favoritePosts: [PostAPIModel]?
    var favoriteChefs: [ChefAPIModel]?
    
//    override func initialize(json: Dictionary<String, AnyObject>, skip: [String])
//    {
//        let skip: [String] = ["favoritePosts", "favoriteChefs", ]
//        
//        let posts = json["favorite_posts"] as! [Dictionary<String, AnyObject>]
//        let chefs = json["favorite_chefs"] as! [Dictionary<String, AnyObject>]
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