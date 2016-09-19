//
//  ViewController+.swift
//  Dragon
//
//  Created by Michael Fourre on 7/27/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func runOnMainThread(runnable: (() -> Void)?)
    {
        if let block = runnable
        {
            NSOperationQueue.mainQueue().addOperationWithBlock(block)
        }
        else
        {
            Log.warning("UIViewController.runOnMainThread(runnable:) received nil runnable")
        }
    }
    
    func presentViewControllerOnMainThread(viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
    {
        self.runOnMainThread({ () -> Void in
            self.presentViewController(viewControllerToPresent, animated: animated, completion: completion)
        })
    }
}
