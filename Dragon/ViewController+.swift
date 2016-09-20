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
    func runOnMainThread(_ runnable: (() -> Void)?)
    {
        if let block = runnable
        {
            OperationQueue.main.addOperation(block)
        }
        else
        {
            Log.warning("UIViewController.runOnMainThread(runnable:) received nil runnable")
        }
    }
    
    func presentViewControllerOnMainThread(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
    {
        self.runOnMainThread({ () -> Void in
            self.present(viewControllerToPresent, animated: animated, completion: completion)
        })
    }
}
