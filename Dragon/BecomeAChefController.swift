//
//  BecomeAChefViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 9/25/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit

class BecomeAChefViewController: UIViewController {

    var firstLaunch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if (firstLaunch) //If first time opening, default to Home tab
        {
            self.tabBarController?.selectedIndex = 2
            firstLaunch = false
        }
    }

}