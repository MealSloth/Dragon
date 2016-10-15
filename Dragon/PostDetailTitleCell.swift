//
//  PostDetailTitleCell.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class PostDetailTitleCell: UITableViewCell
{
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var imageChef: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var blob: UIImage?
    
    func populate(withPost post: Post?)
    {
        if let post = post
        {
            self.activityIndicator.enable()
            if let results = Blob.fromAlbumID(post.albumID),
                let first = results[safe: 0]
            {
                UIImage.fromURL(first.url, completion: { (image) -> Void in
                    self.populateImage(withBlob: image)
                })
            }
            else
            {
                BlobRequest(withAlbumID: post.albumID).request(
                    onCompletion: { (result: BlobResult) -> Void in
                        if let first = result.blobs?[safe: 0]
                        {
                            self.populateImage(withBlob: UIImage.fromURL(first.url))
                        }
                        else
                        {
                            Log.warning("BlobRequest returned nil blob(s)")
                        }
                    },
                    onError: { (error) -> Void in
                        Log.error("Error during BlobRequest: \(error)")
                    }
                )
            }
        }
        else
        {
            Log.error("Attempted to populate PostDetailTitleCell with nil Post")
        }
    }
    
    func populateImage(withBlob blob: UIImage?)
    {
        self.runOnMainThread({ () -> Void in
            self.blob = blob
            self.imagePost.image = self.blob
            self.activityIndicator.disable()
        })
    }
}
