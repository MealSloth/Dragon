//
//  HomeViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 10/3/15.
//  Copyright © 2015 MealSloth. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController
{
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    let mealRatioWidth: Int = 2
    let mealRatioHeight: Int = 1
    
    var screenHeight: CGFloat {
        get {
            return UIScreen.mainScreen().bounds.size.height
        }
    }
    var screenWidth: CGFloat {
        get {
            return UIScreen.mainScreen().bounds.size.width
        }
    }
    var mealViewHeight: CGFloat {
        get {
            return UIScreen.mainScreen().bounds.size.width * CGFloat(mealRatioHeight)/CGFloat(mealRatioWidth)
        }
    }
    var mealViewWidth: CGFloat {
        get {
            return UIScreen.mainScreen().bounds.size.width
        }
    }
    
    var scrollViewHeight: CGFloat = 0.0
    
    var meals: Array<UIButton> = []
    
    var mealsCount: Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mealsCount = 20
        
        for (var i = 0; i < mealsCount; i++)
        {
            createMealButton()
        }
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews();
        
        self.scrollView.frame = self.view.bounds;
        self.scrollView.contentSize.height = scrollViewHeight
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createMealButton()
    {
        let newButton = UIButton()
        newButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.setBackgroundImage(UIImage(named: "SampleMeal"), forState: .Normal)
        contentView.addSubview(newButton)
        
        var verticalPin: NSLayoutConstraint
        var leftPin: NSLayoutConstraint
        var rightPin: NSLayoutConstraint
        
        if (meals.count < 1)
        {
            verticalPin = newButton.topAnchor.constraintEqualToAnchor(contentView.topAnchor)
            leftPin = newButton.leftAnchor.constraintEqualToAnchor(contentView.leftAnchor)
            rightPin = newButton.rightAnchor.constraintEqualToAnchor(contentView.rightAnchor)
        }
        else
        {
            verticalPin = newButton.topAnchor.constraintEqualToAnchor(meals[meals.count-1].bottomAnchor)
            leftPin = newButton.leftAnchor.constraintEqualToAnchor(meals[meals.count-1].leftAnchor)
            rightPin = newButton.rightAnchor.constraintEqualToAnchor(meals[meals.count-1].rightAnchor)
        }
        let horizontalConstraint = newButton.centerXAnchor.constraintEqualToAnchor(contentView.centerXAnchor)
        let widthConstraint = newButton.widthAnchor.constraintEqualToAnchor(nil, constant: mealViewWidth)
        let heightConstraint = newButton.heightAnchor.constraintEqualToAnchor(nil, constant: mealViewHeight)
        NSLayoutConstraint.activateConstraints([horizontalConstraint, widthConstraint, heightConstraint, verticalPin, leftPin, rightPin])
        
        meals.append(newButton)
        
        scrollViewHeight += mealViewHeight
    }
    
}