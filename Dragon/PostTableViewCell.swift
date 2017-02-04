//
//  PostTableViewCell.swift
//  Dragon
//
//  Created by Michael Fourre on 7/28/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postContainer: UIView!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var imageChef: UIImageView!
    @IBOutlet weak var imageStars: UIImageView!
    @IBOutlet weak var labelPostName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var post: Post?
    var blob: Blob?
    
    func populate(withPost post: Post) {
        self.activityIndicator.enable()
        self.imagePost.image = nil
        self.post = post
        self.labelPostName.text = self.post?.name
        self.labelPrice.text = "$8.00"
        self.labelTime.text = "1:00pm - 3:00pm"
        self.populateImage()
    }
    
    fileprivate func populateImage() {
        self.runOnBackgroundThread({ () -> Void in
            if let blob = Blob.fromAlbumID(self.post?.albumID)?.first {
                self.blob = blob
                let _ = self.blob?.image //Load lazy image in background thread
                self.display(animated: true)
            } else {
                guard let post = self.post else { return }
                BlobRequest(withAlbumID: post.albumID).request(
                    onCompletion: { (result: BlobResult) -> Void in
                        self.blob = result.blobs?.first
                        let _ = self.blob?.image //Load lazy image in background thread
                        self.display(animated: true)
                    }
                )
            }
        })
    }
    
    fileprivate func display(animated: Bool = true) {
        let changes = { () -> Void in
            self.postContainer.alpha = 1.0
            self.imagePost.image = self.blob?.image
            self.activityIndicator.disable()
        }
        
        self.runOnMainThread({ () -> Void in
            animated ? UIView.animate(withDuration: 0.3, animations: changes) : changes()
        })
    }
}
