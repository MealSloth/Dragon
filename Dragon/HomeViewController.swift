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
    
    let mealRatioWidth: Int = 64
    let mealRatioHeight: Int = 39
    
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
    var testBtns: Array<UIButton> = []
    
    var testView = UIView()
    
    var mealsCount: Int = 1
    
    var firstLaunch = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for (var i = 0; i < mealsCount; i++)
        {
            createMealButton()
        }
        
        createTestButtons()
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
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if (firstLaunch)
        {
            print(meals[0].actionsForTarget(self, forControlEvent: UIControlEvents.TouchUpInside))
            firstLaunch = false
        }
    }
    
    func testBtnAction(sender: UIButton!)
    {
        createMealButton()
        print("Worked")
    }
    
    func test2BtnAction(sender: UIButton!)
    {
        removeMealButton()
        print("Worked")
    }
    
    func mealTapped(sender:UIButton!)
    {
        print("Pressed \(meals.indexOf(sender))")
        self.performSegueWithIdentifier("MealConfirmation", sender:self)
    }
    
    func updateScrollViewHeight() -> CGFloat
    {
        if (meals.count > 1)
        {
            scrollViewHeight = mealViewHeight * CGFloat(meals.count)
            self.scrollView.contentSize.height = scrollViewHeight
            return scrollViewHeight
        }
        else
        {
            scrollViewHeight = 50
            self.scrollView.contentSize.height = scrollViewHeight
            return scrollViewHeight
        }
    }
    
    func removeMealButton()
    {
        if (meals.count > 0)
        {
            meals[meals.count-1].removeFromSuperview()
            meals.removeLast()
            updateScrollViewHeight()
        }
        
        print(testBtns[0])
    }
    
    func createTestButtons()
    {
        /*Superview for buttons*/
        testView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(testView)
        NSLayoutConstraint.activateConstraints([testView.widthAnchor.constraintEqualToAnchor(nil, constant: screenWidth),
            testView.heightAnchor.constraintEqualToAnchor(nil, constant: screenHeight),
            testView.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor),
            testView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor),
            testView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor)])
        
        /*Button for adding meal buttons*/
        let testBtn = UIButton()
        testBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        testBtn.translatesAutoresizingMaskIntoConstraints = false
        testBtn.setBackgroundImage(UIImage(named: "Settings"), forState: UIControlState.Normal)
        testBtn.addTarget(self, action: "testBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        testView.addSubview(testBtn)
        
        NSLayoutConstraint.activateConstraints([testBtn.topAnchor.constraintEqualToAnchor(scrollView.topAnchor),
            testBtn.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor),
            testBtn.widthAnchor.constraintEqualToAnchor(nil, constant: 50),
            testBtn.heightAnchor.constraintEqualToAnchor(nil, constant: 50)])
        
        testBtns.append(testBtn)
        
        /*Button for removing meal buttons*/
        let test2Btn = UIButton()
        test2Btn.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        test2Btn.translatesAutoresizingMaskIntoConstraints = false
        test2Btn.setBackgroundImage(UIImage(named: "Settings"), forState: UIControlState.Normal)
        test2Btn.addTarget(self, action: "test2BtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
        testView.addSubview(test2Btn)
        
        NSLayoutConstraint.activateConstraints([test2Btn.topAnchor.constraintEqualToAnchor(scrollView.topAnchor),
            test2Btn.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor),
            test2Btn.widthAnchor.constraintEqualToAnchor(nil, constant: 50),
            test2Btn.heightAnchor.constraintEqualToAnchor(nil, constant: 50)])
        
        testBtns.append(test2Btn)
    }
    
    func createMealButton()
    {
        let newButton = UIButton()
        newButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        newButton.translatesAutoresizingMaskIntoConstraints = false
        newButton.setBackgroundImage(UIImage(named: "Meal1"), forState: UIControlState.Normal)
        newButton.addTarget(self, action: "mealTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(newButton)
        
        if (meals.count < 1)
        {
            NSLayoutConstraint.activateConstraints([newButton.topAnchor.constraintEqualToAnchor(scrollView.topAnchor),
                newButton.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor),
                newButton.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor)])
        }
        else
        {
            NSLayoutConstraint.activateConstraints([newButton.topAnchor.constraintEqualToAnchor(meals[meals.count-1].bottomAnchor),
                newButton.leadingAnchor.constraintEqualToAnchor(meals[meals.count-1].leadingAnchor),
                newButton.trailingAnchor.constraintEqualToAnchor(meals[meals.count-1].trailingAnchor)])
        }
        
        NSLayoutConstraint.activateConstraints([newButton.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor),
            newButton.widthAnchor.constraintEqualToAnchor(nil, constant: mealViewWidth),
            newButton.heightAnchor.constraintEqualToAnchor(nil, constant: mealViewHeight)])
        
        meals.append(newButton)
        scrollView.bringSubviewToFront(testView)
        updateScrollViewHeight()
    }
    
}