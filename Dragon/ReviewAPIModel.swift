//
//  ReviewAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class ReviewAPIModel: APIModel
{
    var id: String!
    var postID: String!
    var consumerID: String!
    var rating: NSNumber!
    var title: String?
    var summary: String?
    var time: String!
}