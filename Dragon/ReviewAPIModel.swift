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
    var time: String!
    
    private var reviewDescription: String?
    override var description: String {
        get
        {
            return self.reviewDescription!
        }
        set(value)
        {
            self.reviewDescription = value
        }
    }
    
    override func initialize(json: Dictionary<String, AnyObject>)
    {
        super.initialize(json)
        self.reviewDescription = json["description"] as? String
    }
}