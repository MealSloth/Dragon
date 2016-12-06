//
//  BlobResult.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class BlobResult: APIResult
{
    var blob: Blob?
    var blobs: [Blob]?
    
    required init(result: [String: Any])
    {
        if let blob = result["blob"] as? [String: Any]
        {
            self.blob = Blob.insertOrUpdate(BlobAPIModel(json: blob))
        }
        else
        {
            self.blobs = []
            if let blobs = result["blobs"] as? [[String: Any]]
            {
                for blob in blobs
                {
                    if let managedBlob = Blob.insertOrUpdate(BlobAPIModel(json: blob))
                    {
                        self.blobs?.append(managedBlob)
                    }
                }
            }
            else
            {
                Log.error("Could not parse BlobResult")
            }
        }
    }
}
