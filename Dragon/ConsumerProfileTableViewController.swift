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
    let cells = ["Title", "Order", "Favorite", "Profile", "BecomeAChef", "Feedback", ]
    
    enum ConsumerProfileTableViewControllerSegue: String
    {
        case editProfileTableViewController = "Segue_ConsumerProfileTableViewController->EditProfileTableViewController"
        
        static func from(string: String?) -> ConsumerProfileTableViewControllerSegue?
        {
            guard let identifier = string else { return nil }
            return self.init(rawValue: identifier)
        }
    }
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.register(UINib(nibName: "ConsumerProfileTitleCell", bundle: nil), forCellReuseIdentifier: "ConsumerTitleCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let destination = ConsumerProfileTableViewControllerSegue.from(string: segue.identifier) else { return }
        switch destination
        {
            case .editProfileTableViewController:
                (segue.destination as? EditProfileTableViewController)?.user = sender as? User
                break
        }
    }
    
    // MARK: TableView Delegates
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if case 0..<self.cells.count = indexPath.row
        {
            let identifier = "ConsumerProfile\(self.cells[indexPath.row])Cell"
            return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        else
        {
            Log.error("indexPath.row exceeds expected bounds")
            return tableView.dequeueReusableCell(withIdentifier: "ConsumerProfileTitleCell", for: indexPath)
        }
    }
    
    // MARK: Misc
    fileprivate func segue(to destination: ConsumerProfileTableViewControllerSegue, withUser user: User?)
    {
        self.performSegue(withIdentifier: destination.rawValue, sender: user)
    }
}
