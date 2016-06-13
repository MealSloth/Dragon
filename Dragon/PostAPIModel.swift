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
    var orderCount: Int!
    var capacity: Int!
    var postStatus: Int!
    var postTime: String!
    var expireTime: String!
    
    private var postDescription: String?
    override var description: String {
        get
        {
            return self.postDescription!
        }
        set(value)
        {
            self.postDescription = value
        }
    }
    
    override func initialize(json: Dictionary<String, AnyObject>)
    {
        super.initialize(json)
        self.postDescription = json["description"] as? String
    }
}