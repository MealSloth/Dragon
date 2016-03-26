//
//  ProfileViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 10/3/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet var username: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    @IBAction func editProfile(sender: AnyObject) {
        self.performSegueWithIdentifier("EditConsumerProfile", sender: self)
    }
    
    func displayUser() {
        let currentUser : Dictionary = DatabaseOperations.getCurrentUser()!
        
        self.username.text = (currentUser["first_name"]! as! String) + " " + (currentUser["last_name"]! as! String)
        self.email.text = (currentUser["email"]! as! String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageProcess.makeRoundImage(profileImage)
    }
    
    override func viewWillAppear(animated: Bool) {
        displayUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}