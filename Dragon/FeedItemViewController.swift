//
//  FeedItemViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 7/28/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class FeedItemViewController: UIViewController
{
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var imageChefProfile: UIImageView!
    
    var post: Post!
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imageChefProfileInit()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Misc
    func imageChefProfileInit()
    {
        self.imageChefProfile.layer.zPosition = 1001
        self.imageChefProfile.makeCircular()
    }
}
