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
    var blob: BlobAPIModel?
    var blobs: [BlobAPIModel]?
    
    init(result: Dictionary<String, AnyObject>)
    {
        if let blob = result["blob"] as? Dictionary<String, AnyObject>
        {
            self.blob = BlobAPIModel(json: blob)
        }
        else
        {
            self.blobs = []
            if let blobs = result["blobs"] as? [Dictionary<String, AnyObject>]
            {
                for blob in blobs
                {
                    self.blobs?.append(BlobAPIModel(json: blob))
                }
            }
            else
            {
                Log.string("Could not parse BlobResult")
            }
        }
    }
}