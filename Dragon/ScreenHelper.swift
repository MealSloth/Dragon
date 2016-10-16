//
//  ScreenHelpers.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

open class ScreenHelper
{
    open static var screenWidth: CGFloat
    {
        if UIInterfaceOrientationIsPortrait(screenOrientation)
        {
            return UIScreen.main.bounds.size.width
        }
        else
        {
            return UIScreen.main.bounds.size.height
        }
    }
    
    open static var screenHeight: CGFloat
    {
        if UIInterfaceOrientationIsPortrait(screenOrientation)
        {
            return UIScreen.main.bounds.size.height
        }
        else
        {
            return UIScreen.main.bounds.size.width
        }
    }
    
    open static var screenOrientation: UIInterfaceOrientation
    {
        return UIApplication.shared.statusBarOrientation
    }
}
