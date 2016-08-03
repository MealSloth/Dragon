//
//  ScreenHelpers.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

public class ScreenHelpers
{
    public static var screenWidth: CGFloat
    {
        if UIInterfaceOrientationIsPortrait(screenOrientation)
        {
            return UIScreen.mainScreen().bounds.size.width
        }
        else
        {
            return UIScreen.mainScreen().bounds.size.height
        }
    }
    
    public static var screenHeight: CGFloat
    {
        if UIInterfaceOrientationIsPortrait(screenOrientation)
        {
            return UIScreen.mainScreen().bounds.size.height
        }
        else
        {
            return UIScreen.mainScreen().bounds.size.width
        }
    }
    
    public static var screenOrientation: UIInterfaceOrientation
    {
        return UIApplication.sharedApplication().statusBarOrientation
    }
}