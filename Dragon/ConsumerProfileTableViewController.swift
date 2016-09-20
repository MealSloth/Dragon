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
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (indexPath as NSIndexPath).row == 0
        {
            return tableView.dequeueReusableCell(withIdentifier: "ConsumerProfileTitleCell", for: indexPath)
        }
        else if (indexPath as NSIndexPath).row == 1
        {
            return tableView.dequeueReusableCell(withIdentifier: "ConsumerProfileOrderCell", for: indexPath)
        }
        else if (indexPath as NSIndexPath).row == 2
        {
            return tableView.dequeueReusableCell(withIdentifier: "ConsumerProfileFavoriteCell", for: indexPath)
        }
        else if (indexPath as NSIndexPath).row == 3
        {
            return tableView.dequeueReusableCell(withIdentifier: "ConsumerProfileProfileCell", for: indexPath)
        }
        else if (indexPath as NSIndexPath).row == 4
        {
            return tableView.dequeueReusableCell(withIdentifier: "ConsumerProfileBecomeAChefCell", for: indexPath)
        }
        else if (indexPath as NSIndexPath).row == 5
        {
            return tableView.dequeueReusableCell(withIdentifier: "ConsumerProfileFeedbackCell", for: indexPath)
        }
        else
        {
            Log.error("indexPath.row exceeds expected bounds")
            return tableView.dequeueReusableCell(withIdentifier: "ConsumerProfileTitleCell", for: indexPath)
        }
    }
}
