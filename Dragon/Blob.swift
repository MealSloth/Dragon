//
//  Blob.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class Blob: Model
{
    @NSManaged var id: String!
    @NSManaged var albumID: String!
    @NSManaged var gcsID: String!
    @NSManaged var contentType: String?
    @NSManaged var time: Date!
    @NSManaged var url: String!
    
    lazy var image: UIImage? = {
        return UIImage.fromURL(self.url)
    }()
    
    static func fromAlbumID(_ id: String?) -> [Blob]?
    {
        return self.from("albumID", withValue: id)
    }
}
