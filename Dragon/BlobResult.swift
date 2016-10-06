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
    
    required init(result: Dictionary<String, AnyObject>)
    {
        if let blob = result["blob"] as? Dictionary<String, AnyObject>
        {
            self.blob = Blob(BlobAPIModel(json: blob))
        }
        else
        {
            self.blobs = []
            if let blobs = result["blobs"] as? [Dictionary<String, AnyObject>]
            {
                for blob in blobs
                {
                    self.blobs?.append(Blob(BlobAPIModel(json: blob)))
                }
            }
            else
            {
                Log.error("Could not parse BlobResult")
            }
        }
    }
}
