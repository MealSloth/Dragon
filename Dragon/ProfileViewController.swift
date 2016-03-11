//
//  ProfileViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 10/3/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit
import Parse
import CoreData

class ProfileViewController: UIViewController {
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var username: UILabel!
    @IBOutlet var gender: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var birthday: UILabel!


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
        
        /*
        //dispatch_async(dispatch_get_main_queue()) {
        
        let url = NSURL(string: "http://api.mealsloth.com/user-model-from-id/5782cd13-653d-43da-b384-38d06bd14fa2/")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data{
                
                do{
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    if let j1 = jsonResult["first_name"] as? String {
                        self.username.text = j1
                    }
                    if let j2 = jsonResult["gender"] as? String {
                        if j2 == "0" {
                            self.gender.text = "Male"
                        }else{
                            self.gender.text = "Female"
                        }
                    }
                    if let j3 = jsonResult["phone_number"] as? String {
                        self.phoneNumber.text = j3
                    }
                    if let j4 = jsonResult["email"] as? String {
                        self.email.text = j4
                    }
                    if let j5 = jsonResult["date_of_birth"] as? NSString {
                        self.birthday.text = j5.substringWithRange(NSRange(location: 0, length: 10))
                    }

                }catch {
                    //print("JSON failed")
                }
            }
        }
        
        task.resume()
        */
            
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false    //for display
        
        do{
            let result = try context.executeFetchRequest(request)
            print(result.count)
            if result.count > 0{
                for user in result as! [NSManagedObject]{
                    
                    if let j1 = user.valueForKey("first_name") {
                        self.username.text = j1 as? String
                    }
                    
                    if let j2 = user.valueForKey("phone_number") {
                        self.phoneNumber.text = j2 as? String
                    }
                    
                    if let j3 = user.valueForKey("gender"){
                        self.gender.text = j3 as? String
                    }
                    
                    if let j4 = user.valueForKey("email"){
                        self.email.text = j4 as? String
                    }
                    
                    //print(user.valueForKey("id")!)
                    //print(user.valueForKey("phone_number")!)
                }
            }
        }catch{
            print("fetch failed")
        }
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