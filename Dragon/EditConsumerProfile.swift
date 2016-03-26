//
//  EditConsumerProfile.swift
//  Dragon
//
//  Created by Hongyi on 16/3/25.
//  Copyright © 2016年 MealSloth. All rights reserved.
//

import UIKit

class EditConsumerProfile: UIViewController {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var birthday: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //create an alert, with a "OK" button. When press the button the alert will dismiss.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)    //display the alert
    }
    
    func parseDOB() -> String {
        
        let date : String = birthday.text!
        if(date == ""){
            return ""
        }
        
        var newDate : String = ""
        //1900-01-01T00:00:00.000000
        newDate += date.substringWithRange(Range<String.Index>(start: date.startIndex.advancedBy(6), end: date.endIndex))
        newDate += "-"
        newDate += date.substringWithRange(Range<String.Index>(start: date.startIndex, end: date.endIndex.advancedBy(-8)))
        newDate += "-"
        newDate += date.substringWithRange(Range<String.Index>(start: date.startIndex.advancedBy(3), end: date.endIndex.advancedBy(-5)))
        newDate += "T00:00:00.000000"
        
        return newDate
    }
    
    @IBAction func updateProfile(sender: AnyObject) {
        
        //TODO: add input check
        
        var userProfile : Dictionary = DatabaseOperations.getCurrentUser()!
        userProfile.removeValueForKey("email")
        
        //print(userProfile)
        
        if(firstName.text != "" && firstName.text != (userProfile["first_name"] as! String)){
            userProfile["first_name"] = firstName.text
        }else{
            userProfile.removeValueForKey("first_name")
        }
        
        if(lastName.text != "" && lastName.text != (userProfile["last_name"] as! String)){
            userProfile["last_name"] = lastName.text
        }else{
            userProfile.removeValueForKey("last_name")
        }
        
        if(phoneNumber.text != "" && phoneNumber.text != (userProfile["phone_number"] as! String)){
            userProfile["phone_number"] = phoneNumber.text
        }else{
            userProfile.removeValueForKey("phone_number")
        }
        
        let dob = parseDOB()
        if(dob != "" && dob != (userProfile["date_of_birth"] as! String)){
            userProfile["date_of_birth"] = dob
        }else{
            userProfile.removeValueForKey("date_of_birth")
        }
        
        //TODO: set gender as choose list
        
        var userGender : String = ""
        if((userProfile["gender"] as! Int) == 0){
            userGender = "Male"
        }else{
            userGender = "Female"
        }
        if(gender.text != "" && gender.text != userGender){
            if(gender.text == "Male"){
                userProfile["gender"] = 0
            }else{
                userProfile["gender"] = 1
            }
        }else{
            userProfile.removeValueForKey("gender")
        }
        
        print(userProfile)
        
        /*
            check if the user do change something
        */
        if(userProfile.count == 1){
            //displayAlert("Oops", message: "Nothing changed")
        }else{
            let result = APIOperations.postRequest(userProfile, url: "http://api.mealsloth.com/user/modify/")
            
            /*
                check if update is successful
                if yes, update core data
            */
            if(result["message"] as! String == "Success"){
                userProfile.removeValueForKey("user_id")
                DatabaseOperations.updateUserProfile(userProfile)
            }else{
                displayAlert("Update Failed", message: "Please try later")
            }
        }
    }
}
