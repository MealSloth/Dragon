//
//  PostTableViewCell.swift
//  Dragon
//
//  Created by Michael Fourre on 7/28/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell
{
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var imageChef: UIImageView!
    @IBOutlet weak var labelPostName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var post: Post?
    var blob: Blob?
    var blobImage: UIImage?
    
    func populate(withPost post: Post)
    {
        self.activityIndicator.enable()
        self.imagePost.image = nil
        self.post = post
        self.labelPostName.text = self.post?.name
        self.labelPrice.text = "$8"
        self.populateImage()
    }
    
    fileprivate func populateImage()
    {
        self.runOnBackgroundThread({ () -> Void in
            if let blob = Blob.fromAlbumID(self.post?.albumID)?[safe: 0]
            {
                self.blobImage = UIImage.fromURL(blob.url)
                self.display()
            }
            else
            {
                if let post = self.post
                {
                    BlobRequest(withAlbumID: post.albumID).request(
                        onCompletion: { (result: BlobResult) -> Void in
                            if let blob = result.blobs?[safe: 0], let image = UIImage.fromURL(blob.url)
                            {
                                self.blobImage = image
                                self.display()
                            }
                        },
                        onError: { (error) -> Void in
                            Log.error("Error during BlobRequest(withAlbumID:): \(error)")
                        }
                    )
                }
                else
                {
                    Log.error("PostTableViewCell was populated with a nil Post")
                }
            }
        })
    }
    
    fileprivate func display()
    {
        self.runOnMainThread({ () -> Void in
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.labelPostName.alpha = 1.0
                self.labelPrice.alpha = 1.0
                self.imageChef.alpha = 1.0
                self.imagePost.alpha = 1.0
                self.imagePost.image = self.blobImage
                self.activityIndicator.disable()
            })
        })
    }
}
