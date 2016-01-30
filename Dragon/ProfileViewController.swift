//
//  ProfileViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 10/3/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var scrollView: UIScrollView!    

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
    
    let sideMargin: CGFloat = 60.0
    
    var verticalViews = [Int:Any]()
    
    var profileChefName: String = "Yoshikazu Ono"
    var profileChefLocation: String = "Raleigh, NC"
    var profileChefDescription: String = "Trained sushi chef from Japan, now living in Raleigh, NC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createViews()
    {
        /*Profile Image*/
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(named: "YoshikazuProfile")
        scrollView.addSubview(profileImageView)
        
        NSLayoutConstraint.activateConstraints([profileImageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor, constant: 30.0),
            profileImageView.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor)])
        
        verticalViews[0] = profileImageView
        
        /*Chef Name Label*/
        let labelChefName = UILabel()
        labelChefName.translatesAutoresizingMaskIntoConstraints = false
        labelChefName.text = profileChefName
        scrollView.addSubview(labelChefName)
        
        NSLayoutConstraint.activateConstraints([labelChefName.topAnchor.constraintEqualToAnchor(profileImageView.bottomAnchor, constant: 5.0),
            labelChefName.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor)])
        
        verticalViews[1] = labelChefName
        
        /*Chef Location Label*/
        let labelChefLocation = UILabel()
        labelChefLocation.translatesAutoresizingMaskIntoConstraints = false
        labelChefLocation.text = profileChefLocation
        scrollView.addSubview(labelChefLocation)
        
        NSLayoutConstraint.activateConstraints([labelChefLocation.topAnchor.constraintEqualToAnchor(labelChefName.bottomAnchor, constant: 5.0),
            labelChefLocation.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor)])
        
        verticalViews[2] = labelChefLocation
        
        /*Chef Description Label*/
        let labelChefDescription = UILabel()
        labelChefDescription.translatesAutoresizingMaskIntoConstraints = false
        labelChefDescription.text = profileChefDescription
        labelChefDescription.textAlignment = NSTextAlignment.Center
        labelChefDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
        labelChefDescription.numberOfLines = 0
        scrollView.addSubview(labelChefDescription)
        
        NSLayoutConstraint.activateConstraints([labelChefDescription.topAnchor.constraintEqualToAnchor(labelChefLocation.bottomAnchor, constant: 8.0),
            labelChefDescription.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor),
            labelChefDescription.widthAnchor.constraintEqualToConstant(screenWidth - sideMargin)])
        
        verticalViews[3] = labelChefDescription
    }
    
}