//
//  BlobRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct BlobRequest: APIRequest
{
    var method: String = "blob/"
    var json: [String:Any] = [:]
    var host: APIHost = .chimera
    
    init(withBlobID blobID: String?)
    {
        self.initialize(withJSON: [
            "blob_id": blobID ?? "",
        ])
    }
    
    init(withAlbumID albumID: String?)
    {
        self.initialize(withJSON: [
            "album_id": albumID ?? "",
        ])
    }
}
