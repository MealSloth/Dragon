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
    
    var blob: Blob?
    
    func populate(withPost post: Post?)
    {
        if let post = post
        {
            self.activityIndicator.enable()
            if let results = Blob.fromAlbumID(post.albumID),
                let first = results[safe: 0]
            {
                self.blob = first
                let _ = self.blob?.image
                self.populateImage()
            }
            else
            {
                BlobRequest(withAlbumID: post.albumID).request(
                    onCompletion: { (result: BlobResult) -> Void in
                        self.blob = result.blobs?[safe: 0]
                        let _ = self.blob?.image
                        self.populateImage()
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
    
    func populateImage()
    {
        self.runOnMainThread({ () -> Void in
            self.activityIndicator.disable()
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                self.imagePost.image = self.blob?.image
                self.imagePost.alpha = 1.0
            })
        })
    }
}
