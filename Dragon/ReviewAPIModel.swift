//
//  ReviewAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class ReviewAPIModel: AbstractAPIModel
{
    var id: String!
    var postID: String!
    var consumerID: String!
    var rating: Int!
    var title: String?
    var summary: String?
    var time: String!
    
    override func initialize(json: Dictionary<String, AnyObject>, skip: [String])
    {
        let skip: [String] = ["rating", ]
        self.rating = json["rating"] as! Int
        super.initialize(json, skip: skip)
    }
}