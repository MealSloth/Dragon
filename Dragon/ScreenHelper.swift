//
//  ScreenHelpers.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

public struct ScreenHelper {
    public static var screenOrientation = UIApplication.shared.statusBarOrientation
    public static var isPortrait = UIInterfaceOrientationIsPortrait(ScreenHelper.screenOrientation)
    public static var screenWidth = ScreenHelper.isPortrait ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
    public static var screenHeight = ScreenHelper.isPortrait ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
}
