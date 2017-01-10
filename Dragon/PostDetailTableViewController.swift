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
    var post: Post?
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    // MARK: TableView Delegates
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.row
        {
            case 2: return 80.0
            default: return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //TODO: Handle row clicks
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.row
        {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailTitleCell", for: indexPath)
                if let titleCell = cell as? PostDetailTitleCell
                {
                    titleCell.populate(withPost: self.post)
                    return titleCell
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailSummaryCell", for: indexPath)
                if let summaryCell = cell as? PostDetailSummaryCell
                {
                    summaryCell.labelName.text = self.post?.name
                    return summaryCell
                }
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailTimeCell", for: indexPath)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailDescriptionCell", for: indexPath)
                return cell
            default:
                Log.error("indexPath.row exceeds expected bounds")
                return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
