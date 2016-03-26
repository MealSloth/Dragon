//
//  DatabaseOperations.swift
//  Dragon
//
//  Created by Hongyi on 16/3/25.
//  Copyright © 2016年 MealSloth. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseOperations {
    
    static let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    class func userAlreadyLogin () -> Bool {
        
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.executeFetchRequest(request)
            if result.count > 0{
                return true
            }
        }catch{
            print("fetch failed")
        }
        
        return false
    }
    
    class func getCurrentUser () -> Dictionary<String, AnyObject>? {
        
        if !userAlreadyLogin(){
            return nil
        }
        
        var currentUser : Dictionary = [String : AnyObject]()
        
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.executeFetchRequest(request)
            if result.count > 0{
                let tmpUser = result[0] as! NSManagedObject
                
                if let j1 = tmpUser.valueForKey("id"){
                    currentUser["user_id"] = (j1 as! String)
                }
                if let j2 = tmpUser.valueForKey("first_name"){
                    currentUser["first_name"] = (j2 as! String)
                }
                if let j3 = tmpUser.valueForKey("last_name"){
                    currentUser["last_name"] = (j3 as! String)
                }
                if let j4 = tmpUser.valueForKey("gender"){
                    currentUser["gender"] = (j4 as! Int)
                }
                if let j5 = tmpUser.valueForKey("date_of_birth"){
                    currentUser["date_of_birth"] = (j5 as! String)
                }
                if let j6 = tmpUser.valueForKey("email"){
                    currentUser["email"] = (j6 as! String)
                }
                if let j7 = tmpUser.valueForKey("phone_number"){
                    currentUser["phone_number"] = (j7 as! String)
                }
                
                return currentUser
            }
        }catch{
            print("fetch failed")
        }
        
        return nil
    }
    
    class func updateUserProfile(profile : Dictionary<String, AnyObject>) {
        
        if !userAlreadyLogin(){
            return
        }
        
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.executeFetchRequest(request)
            if result.count > 0{
                let tmpUser = result[0] as! NSManagedObject
                
                for (key, value) in profile {
                    tmpUser.setValue(value, forKey: key)
                }
                
                do{
                    try self.context.save()
                }catch{
                    print("there is a problem!")
                }
            }
        }catch{
            print("fetch failed")
        }
    }
    
    class func deleteCurrentUser() -> Bool {
        
        if !userAlreadyLogin() {
            return false
        }
        
        let request = NSFetchRequest(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.executeFetchRequest(request)
            if result.count > 0{
                
                for user:AnyObject in result{
                    context.deleteObject(user as! NSManagedObject)
                }
                
                do{
                    try self.context.save()
                    return true
                }catch{
                    print("there is a problem!")
                }
            }
        }catch{
            print("fetch failed")
        }
        
        return false
    }
    
}
