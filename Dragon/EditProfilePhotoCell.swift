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
            onCompletion: { (result) -> Void in
                _ = result.blob?.image
                MainQueue.sync({ () -> Void in
                    self.profilePhoto.isHidden = true
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.profilePhoto.image = result.blob?.image
                        self.profilePhoto.isHidden = false
                    })
                })
            }
        )
    }
}
