//
//  EditProfilePhotoCell.swift
//  Dragon
//
//  Created by Michael Fourre on 1/10/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

class EditProfilePhotoCell: UITableViewCell, EditProfileCell {
    static let type: EditProfileCellType = .photo
    @IBOutlet weak var profilePhoto: UIImageView!
    var user: User?
    
    func initialize() {
        BlobRequest(withUserID: self.user?.id).request(
            onCompletion: { (result: BlobResult) -> Void in
                _ = result.blob?.image
                self.runOnMainThread({ () -> Void in
                    self.profilePhoto.alpha = 0.0
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.profilePhoto.image = result.blob?.image
                        self.profilePhoto.alpha = 1.0
                    })
                })
            }
        )
    }
}
