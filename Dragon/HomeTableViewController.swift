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
    
    var ratio: CGFloat = 9.0/21.0
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib.init(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        PostPageRequest().request(
            onCompletion: { (result: PostPageResult) -> Void in
                self.handlePostPageResult(result)
            },
            onError: { (error) -> Void in
                Log.Error("Error occurred during PostPageRequest(): \(error)")
            }
        )
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation)
    {
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "Segue_HomeTableViewController->PostDetailTableViewController")
        {
            if let vc = segue.destinationViewController as? PostDetailTableViewController
            {
                if let post = sender as? PostAPIModel
                {
                    if let blob = self.blobs[post.albumID]
                    {
                        vc.post = post
                        vc.blob = blob
                    }
                }
            }
        }
    }
    
    // MARK: TableView Delegates
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return (self.posts.count == 0) ? 0 : 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        let result = (self.posts.count == 0) ? 0.0 : ScreenHelpers.screenWidth * self.ratio + 60.0
        return result
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
            Log.Warning("Failed cast to PostTableViewCell")
            return self.tableView.dequeueReusableCellWithIdentifier("PostTableViewCell", forIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.segue(withPost: self.posts[indexPath.row])
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
    
    private func segue(withPost post: PostAPIModel)
    {
        self.performSegueWithIdentifier("Segue_HomeTableViewController->PostDetailTableViewController", sender: post)
    }
    
    private func populateCell(cell: PostTableViewCell, withPost post: PostAPIModel) -> PostTableViewCell
    {
        //TODO: Get Blob
        self.populateImageForCell(cell, withPost: post)
        
        cell.labelPostName.text = post.name
        cell.labelPrice.text = "$8"
        
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
            onCompletion: { (result: BlobResult) -> Void in
                if let blob = result.blobs?[safe: 0]
                {
                    if let image = UIImage.FromURL(blob.url)
                    {
                        self.blobs[post.albumID] = image
                        self.runOnMainThread({ () -> Void in
                            self.displayCell(cell, withAlbumID: post.albumID)
                        })
                    }
                }
            },
            onError: { (error) -> Void in
                Log.Error("Error during BlobRequest(withAlbumID:): \(error)")
            }
        )
    }
    
    private func displayCell(cell: PostTableViewCell, withAlbumID albumID: String)
    {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            cell.labelPostName.alpha = 1.0
            cell.labelPrice.alpha = 1.0
            cell.imageChef.alpha = 1.0
            cell.imagePost.alpha = 1.0
            cell.imagePost.image = self.blobs[albumID]
        })
    }
}