//
//  Post.swift
//  Dragon
//
//  Created by Michael Fourre on 9/7/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Post: Model {
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
    
    lazy var chef: Chef? = {
        return Chef.fromID(self.chefID)
    }()
    
    lazy var album: Album? = {
        return Album.fromID(self.albumID)
    }()
}

extension Post {
    var status: PostStatus? {
        get { return PostStatus(rawValue: self.postStatus as Int) }
        set { if let value = newValue?.rawValue { self.postStatus = value as NSNumber } }
    }
    
    var location: Location? {
        return Location.fromID(self.chef?.locationID)
    }
}

extension Post {
    static var sorted: [Post]? {
        return Post.sortBy(key: "postTime", ascending: false)
    }
}
