//
//  FoodieProfileController.swift
//  Dragon
//
//  Created by Hongyi on 16/3/18.
//  Copyright © 2016年 MealSloth. All rights reserved.
//

import UIKit

class FoodieProfileController: UIViewController {
    
    @IBAction func myOrder(sender: AnyObject) {
    }
    
    @IBAction func myFavorite(sender: AnyObject) {
        self.performSegueWithIdentifier("FoodieMyFavorite", sender: self)
    }
    
    @IBAction func myProfile(sender: AnyObject) {
        self.performSegueWithIdentifier("FoodieMyProfile", sender: self)
    }
    
    @IBAction func becomeAChef(sender: AnyObject) {
    }
    
    @IBAction func feedback(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        navigationItem.title = ""
        
        if segue.identifier == "FoodieMyProfile" {
            segue.destinationViewController.navigationItem.title = "My Profile"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
