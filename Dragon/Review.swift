//
//  Review.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Review: Model
{
    @NSManaged var id: String!
    @NSManaged var postID: String!
    @NSManaged var consumerID: String!
    @NSManaged var rating: NSNumber!
    @NSManaged var title: String?
    @NSManaged var summary: String?
    @NSManaged var time: NSDate!
}
