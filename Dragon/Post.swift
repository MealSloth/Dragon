//
//  Post.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Post: Model
{
    @NSManaged var id: String!
    @NSManaged var chefID: String!
    @NSManaged var albumID: String!
    @NSManaged var name: String!
    @NSManaged var summary: String!
    @NSManaged var orderCount: NSNumber!
    @NSManaged var capacity: NSNumber!
    @NSManaged var postStatus: NSNumber!
    @NSManaged var postTime: Date!
    @NSManaged var expireTime: Date!
    
    var status: PostStatus? {
        get { return PostStatus(rawValue: self.postStatus as Int) }
        set { if let value = newValue?.rawValue { self.postStatus = value as NSNumber } }
    }
    
    lazy var chef: Chef? = {
        return Chef.fromID(self.chefID)
    }()
    
    lazy var location: Location? = {
        return Location.fromID(self.chef?.locationID)
    }()
    
    lazy var album: Album? = {
        return Album.fromID(self.albumID)
    }()
}
