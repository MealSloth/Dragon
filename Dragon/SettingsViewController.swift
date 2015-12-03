//
//  SettingsViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 10/3/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var contentView: UIView!
    
    var screenHeight: CGFloat {
        get {
            return UIScreen.mainScreen().bounds.size.height
        }
    }
    var screenWidth: CGFloat {
        get {
            return UIScreen.mainScreen().bounds.size.width
        }
    }
    
    var logoutButton = UIButton()
    var settingsText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func logoutButtonAction(sender: UIButton!)
    {
        print("Pressed")
    }
    
    func createViews()
    {
        /*Logout Button*/
        logoutButton.addTarget(self, action: "logoutButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        logoutButton.setTitle("Logout", forState: UIControlState.Normal)
        logoutButton.titleLabel!.font = UIFont(name: "SegoeUI", size: 20)
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = UIColor.grayColor();
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoutButton)
        
        NSLayoutConstraint.activateConstraints([logoutButton.centerXAnchor.constraintEqualToAnchor(contentView.centerXAnchor),
            logoutButton.centerYAnchor.constraintEqualToAnchor(contentView.centerYAnchor),
            logoutButton.widthAnchor.constraintEqualToConstant(150.0),
            logoutButton.heightAnchor.constraintEqualToConstant(60.0)])
    }
    
}