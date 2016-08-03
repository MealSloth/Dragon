//
//  BlobAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class BlobAPIModel: AbstractAPIModel
{
    var id: String!
    var albumID: String!
    var gcsID: String!
    var contentType: String?
    var time: String!
    var url: String!
}