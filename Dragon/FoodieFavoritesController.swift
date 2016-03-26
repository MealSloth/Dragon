//
//  FavoritesViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 9/25/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var mealButtonTable: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews();
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
   
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoritesMealButtonCell", forIndexPath: indexPath) as! MealButtonCell
        
        //       cell.mealImage.image
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showFavoriteMealDetails", sender: self)
    }


}

