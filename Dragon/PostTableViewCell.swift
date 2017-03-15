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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var postContainer: UIView!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var imageChef: UIImageView!
    @IBOutlet weak var imageStars: UIImageView!
    @IBOutlet weak var labelPostName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    var post: Post?
    
    func populate(with post: Post?) {
        self.activityIndicator.enable()
        self.imagePost.image = nil
        self.post = post
        self.labelPostName.text = self.post?.name
        self.labelPrice.text = "$8.00"
        self.labelTime.text = "1:00pm - 3:00pm"
        self.populateImage()
    }
    
    fileprivate func populateImage() {
        if let blob = Blob.fromAlbumID(self.post?.albumID)?.first {
            self.imagePost.display(blob: blob, activityIndicator: self.activityIndicator)
        } else {
            guard let post = self.post else { return }
            BlobRequest(withAlbumID: post.albumID).request(
                onCompletion: { (result) -> Void in
                    self.imagePost.display(blob: result.blobs?.first, activityIndicator: self.activityIndicator)
                }
            )
        }
    }
}
