//
//  BlobRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

struct BlobRequest: APIRequest {
    var method: String = "blob/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withBlobID blobID: String?) {
        self.json["blob_id"] = blobID
    }
    
    init(withUserID userID: String?) {
        self.json["user_id"] = userID
    }
    
    init(withAlbumID albumID: String?) {
        self.json["album_id"] = albumID
    }
}
