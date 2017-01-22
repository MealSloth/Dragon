//
//  BlobResult.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

struct BlobResult: APIResult
{
    var blob: Blob?
    var blobs: [Blob]?
    
    init(result: [String:Any])
    {
        if let blob = result["blob"] as? [String:Any]
        {
            self.blob = Blob.insert(BlobAPIModel(json: blob))
        }
        else
        {
            self.blobs = []
            if let blobs = result["blobs"] as? [[String:Any]]
            {
                blobs.forEach({ if let blob = Blob.insert(BlobAPIModel(json: $0)) { self.blobs?.append(blob) } })
            }
        }
    }
}
