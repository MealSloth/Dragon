//
//  Blob.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Blob: Model
{
    @NSManaged var id: String!
    @NSManaged var albumID: String!
    @NSManaged var gcsID: String!
    @NSManaged var contentType: String?
    @NSManaged var time: String!
    @NSManaged var url: String!
}