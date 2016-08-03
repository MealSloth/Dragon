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
    
    var post: PostAPIModel?
}