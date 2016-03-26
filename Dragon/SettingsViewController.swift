//
//  SettingsViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 10/3/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logOut(sender: AnyObject) {
        
        if DatabaseOperations.deleteCurrentUser() {
            self.performSegueWithIdentifier("logout", sender: self)
        }
    }    
    
}