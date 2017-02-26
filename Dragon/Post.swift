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
    var status: PostStatus {
        get { return PostStatus(rawValue: self.postStatus.intValue) ?? .inactive }
        set { self.postStatus = NSNumber(value: newValue.rawValue) }
    }
    
    var ordersCount: Int {
        get { return self.orderCount.intValue }
        set { self.orderCount = NSNumber(value: newValue) }
    }
    
    var postCapacity: Int {
        get { return self.capacity.intValue }
        set { self.capacity = NSNumber(value: newValue) }
    }
    
    var location: Location? {
        return Location.fromID(self.chef?.locationID)
    }
    
    var blob: Blob? {
        return Blob.fromAlbumID(self.albumID)?.first
    }
}

extension Post {
    static var sorted: [Post]? {
        return Post.sortBy(key: "postTime", ascending: false)
    }
}
