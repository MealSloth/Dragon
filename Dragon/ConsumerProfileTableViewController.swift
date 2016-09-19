//
//  ConsumerProfileTableViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class ConsumerProfileTableViewController: UITableViewController
{
    var consumer: ConsumerAPIModel!
    var user: UserAPIModel!
    
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
        return 6
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            return tableView.dequeueReusableCellWithIdentifier("ConsumerProfileTitleCell", forIndexPath: indexPath)
        }
        else if indexPath.row == 1
        {
            return tableView.dequeueReusableCellWithIdentifier("ConsumerProfileOrderCell", forIndexPath: indexPath)
        }
        else if indexPath.row == 2
        {
            return tableView.dequeueReusableCellWithIdentifier("ConsumerProfileFavoriteCell", forIndexPath: indexPath)
        }
        else if indexPath.row == 3
        {
            return tableView.dequeueReusableCellWithIdentifier("ConsumerProfileProfileCell", forIndexPath: indexPath)
        }
        else if indexPath.row == 4
        {
            return tableView.dequeueReusableCellWithIdentifier("ConsumerProfileBecomeAChefCell", forIndexPath: indexPath)
        }
        else if indexPath.row == 5
        {
            return tableView.dequeueReusableCellWithIdentifier("ConsumerProfileFeedbackCell", forIndexPath: indexPath)
        }
        else
        {
            Log.error("indexPath.row exceeds expected bounds")
            return tableView.dequeueReusableCellWithIdentifier("ConsumerProfileTitleCell", forIndexPath: indexPath)
        }
    }
}
