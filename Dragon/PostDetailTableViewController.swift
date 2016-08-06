//
//  PostDetailTableViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class PostDetailTableViewController: UITableViewController
{
    var post: PostAPIModel!
    var blob: UIImage!
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    // MARK: TableView Delegates
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //TODO: Handle row clicks
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("PostDetailTitleCell", forIndexPath: indexPath)
            if let titleCell = cell as? PostDetailTitleCell
            {
                titleCell.imagePost.image = self.blob
                return titleCell
            }
            else
            {
                return cell
            }
            
        }
        else if (indexPath.row == 1)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("PostDetailSummaryCell", forIndexPath: indexPath)
            if let summaryCell = cell as? PostDetailSummaryCell
            {
                summaryCell.labelName.text = self.post.name
                return summaryCell
            }
            else
            {
                return cell
            }
        }
        else
        {
            Log.Error("indexPath.row exceeds expected bounds")
            return tableView.dequeueReusableCellWithIdentifier("PostDetailTitleCell", forIndexPath: indexPath)
        }
    }
}