//
//  DisplayAlert.swift
//  Dragon
//
//  Created by Hongyi on 16/3/26.
//  Copyright © 2016年 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class DisplayAlert {
    
    class func displayAlert(title: String, message: String, sender: AnyObject?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            sender!.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        sender!.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}