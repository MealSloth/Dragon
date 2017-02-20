//
//  PostDetailTitleCell.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class PostDetailTitleCell: UITableViewCell {
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var imageChef: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var blob: Blob?
    
    static func instance(from tableView: UITableView, at indexPath: IndexPath, for post: Post?) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailTitleCell", for: indexPath)
        guard let titleCell = cell as? PostDetailTitleCell else { return cell }
        titleCell.populate(withPost: post)
        return titleCell
    }
    
    func populate(withPost post: Post?) {
        guard let post = post else { return }
        self.activityIndicator.enable()
        if let first = Blob.fromAlbumID(post.albumID)?.first {
            self.blob = first
            let _ = self.blob?.image //Preload lazily loaded image
            self.populateImage()
        } else {
            BlobRequest(withAlbumID: post.albumID).request(
                onCompletion: { (result: BlobResult) -> Void in
                    self.blob = result.blobs?.first
                    let _ = self.blob?.image //Preload lazily loaded image
                    self.populateImage()
                }
            )
        }
    }
    
    fileprivate func populateImage() {
        MainQueue.sync({ () -> Void in
            self.activityIndicator.disable()
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                self.imagePost.image = self.blob?.image
                self.imagePost.alpha = 1.0
            })
        })
    }
}
