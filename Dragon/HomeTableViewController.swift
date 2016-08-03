//
//  HomeViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 7/27/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewController: UITableViewController
{
    @IBOutlet weak var scrollView: UIScrollView!
    
    var posts: [PostAPIModel] = []
    var blobs: Dictionary<String, UIImage> = [:]
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib.init(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        self.tableView.contentInset = UIEdgeInsetsMake(38, 0, 0, 0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        PostPageRequest().request(
            onCompletion: { (result) -> Void in
                self.handlePostPageResult(result)
            },
            onError: { (error) -> Void in
                Log.string("Error occurred during PostPageRequest():", type: .error)
                Log.error(error)
            }
        )
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TableView Delegates
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return (self.posts.count == 0) ? 0 : 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return (self.posts.count == 0) ? 0.0 : 250.0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostTableViewCell", forIndexPath: indexPath) as? PostTableViewCell
        {
            let post = self.posts[indexPath.row]
            return self.populateCell(cell, withPost: post)
        }
        else
        {
            Log.string("Failed cast to PostTableViewCell")
            return self.tableView.dequeueReusableCellWithIdentifier("PostTableViewCell", forIndexPath: indexPath)
        }
    }
    
    // MARK: Observers
    func keyboardDidShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            if (self.scrollView.contentOffset.y == 0)
            {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                    self.scrollView.contentInset = insets
                    self.scrollView.scrollIndicatorInsets = insets
                    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y + keyboardSize.height)
                })
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                let insets: UIEdgeInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, keyboardSize.height, 0)
                self.scrollView.contentInset = insets
                self.scrollView.scrollIndicatorInsets = insets
            })
        }
    }
    
    // MARK: Misc
    private func handlePostPageResult(result: PostPageResult?)
    {
        if let posts = result?.posts
        {
            self.posts = posts
            self.tableView.performSelectorOnMainThread(#selector(self.tableView.reloadData), withObject: nil, waitUntilDone: false)
        }
    }
    
    private func populateCell(cell: PostTableViewCell, withPost post: PostAPIModel) -> PostTableViewCell
    {
        //TODO: Get Blob
        self.populateImageForCell(cell, withPost: post)
        
        cell.labelPostName.text = post.name
        cell.labelPrice.text = "$10"
        
        return cell
    }
    
    private func populateImageForCell(cell: PostTableViewCell, withPost post: PostAPIModel)
    {
        if let blob = self.blobs[post.albumID]
        {
            cell.imagePost.image = blob
            return
        }
        
        BlobRequest(withAlbumID: post.albumID).request(
            onCompletion: { (result) -> Void in
                if let blob = result.blobs?[safe: 0]
                {
                    if let image = UIImage.FromURL(blob.url)
                    {
                        self.runOnMainThread({ () -> Void in
                            self.blobs[post.albumID] = image
                            cell.imagePost.image = self.blobs[post.albumID]
                        })
                    }
                }
            },
            onError: { (error) -> Void in
                Log.string("Error during BlobRequest(withAlbumID:)", type: .error)
                Log.error(error)
            }
        )
    }
}