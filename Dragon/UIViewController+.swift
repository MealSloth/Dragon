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
    func presentViewControllerOnMainThread(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
    {
        self.runOnMainThread({ () -> Void in
            self.present(viewControllerToPresent, animated: animated, completion: completion)
        })
    }
}
