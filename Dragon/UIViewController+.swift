//
//  ViewController+.swift
//  Dragon
//
//  Created by Michael Fourre on 7/27/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentViewControllerOnMainThread(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        MainQueue.async({ () -> Void in
            self.present(viewControllerToPresent, animated: animated, completion: completion)
        })
    }
    
    func segue(withIdentifier identifier: String, sender: Any?) {
        MainQueue.async({ () -> Void in
            self.performSegue(withIdentifier: identifier, sender: sender)
        })
    }
}
