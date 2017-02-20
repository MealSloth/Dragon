//
//  PostDetailTableViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class PostDetailTableViewController: UITableViewController {
    var post: Post?
    
    // MARK: Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    // MARK: TableView Delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 2: return 80.0
            default: return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Handle row clicks
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0: return PostDetailTitleCell.instance(from: tableView, at: indexPath, for: post)
            case 1: return PostDetailSummaryCell.instance(from: tableView, at: indexPath, for: post)
            case 2: return tableView.dequeueReusableCell(withIdentifier: "PostDetailTimeCell", for: indexPath)
            case 3: return tableView.dequeueReusableCell(withIdentifier: "PostDetailDescriptionCell", for: indexPath)
            default: return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
