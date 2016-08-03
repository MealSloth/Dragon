//
//  BlobRequest.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class BlobRequest: APIRequestChimera
{
    init(withBlobID blobID: String)
    {
        super.init(method: "blob/")
        self.json["blob_id"] = blobID
    }
    
    init(withAlbumID albumID: String)
    {
        super.init(method: "blob/")
        self.json["album_id"] = albumID
    }
    
    func request(onCompletion completion: ((result: BlobResult) -> Void)? = nil, onError: ((error: NSError?) -> Void)? = nil)
    {
        self.resultHandler = { (result) -> Void in
            completion?(result: BlobResult(result: result))
        }
        self.errorHandler = onError
        super.request()
    }
}