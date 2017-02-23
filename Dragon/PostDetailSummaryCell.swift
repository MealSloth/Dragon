//
//  PostDetailSummaryCell.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class PostDetailSummaryCell: UITableViewCell, InstanceRetrievable {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageStars: UIImageView!
    @IBOutlet weak var labelReviews: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    
    static func instance(from tableView: UITableView, at indexPath: IndexPath, for post: Post?) -> UITableViewCell {
        let cell = self.instance(from: tableView, at: indexPath)
        let summaryCell = cell as? PostDetailSummaryCell
        summaryCell?.labelName.text = post?.name
        return summaryCell ?? cell
    }
}
