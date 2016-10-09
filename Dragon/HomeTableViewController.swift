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
    
    var posts: [Post] = []
    var blobs: Dictionary<String, UIImage> = [:]
    
    var ratio: CGFloat = 9.0/16.0
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        
        if let posts = Post.all()
        {
            self.posts = posts
        }
        
        PostPageRequest().request(
            onCompletion: { (result: PostPageResult) -> Void in
                self.handlePostPageResult(result)
            },
            onError: { (error) -> Void in
                Log.error("Error occurred during PostPageRequest(): \(error)")
            }
        )
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation)
    {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "Segue_HomeTableViewController->PostDetailTableViewController"),
            let vc = segue.destination as? PostDetailTableViewController
        {
            if let post = sender as? Post
            {
                vc.post = post
                if let blob = self.blobs[post.albumID]
                {
                    vc.blob = blob
                }
            }
        }
    }
    
    // MARK: TableView Delegates
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return (self.posts.count == 0) ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let result = (self.posts.count == 0) ? 0.0 : ScreenHelpers.screenWidth * self.ratio + 60.0
        return result
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell
        {
            if let post = self.posts[safe: indexPath.row]
            {
                return self.populateCell(cell, withPost: post)
            }
        }
        Log.warning("Failed cast to PostTableViewCell")
        return self.tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let post = self.posts[safe: indexPath.row]
        {
            self.segue(withPost: post)
        }
    }
    
    // MARK: Misc
    fileprivate func handlePostPageResult(_ result: PostPageResult?)
    {
        if let posts = result?.posts
        {
            self.posts = posts
            self.tableView.performSelector(onMainThread: #selector(self.tableView.reloadData), with: nil, waitUntilDone: false)
        }
    }
    
    fileprivate func segue(withPost post: Post)
    {
        self.performSegue(withIdentifier: "Segue_HomeTableViewController->PostDetailTableViewController", sender: post)
    }
    
    fileprivate func populateCell(_ cell: PostTableViewCell, withPost post: Post) -> PostTableViewCell
    {
        self.populateImageForCell(cell, withPost: post)
        
        cell.labelPostName.text = post.name
        cell.labelPrice.text = "$8"
        
        return cell
    }
    
    fileprivate func populateImageForCell(_ cell: PostTableViewCell, withPost post: Post)
    {
        self.runOnBackgroundThread({ () -> Void in
            if let _ = self.blobs[post.albumID]
            {
                self.runOnMainThread({ () -> Void in
                    self.displayCell(cell, withAlbumID: post.albumID)
                })
            }
            else if let blob = Blob.fromAlbumID(post.albumID)?[safe: 0]
            {
                self.blobs[post.albumID] = UIImage.fromURL(blob.url)
                self.runOnMainThread({ () -> Void in
                    self.displayCell(cell, withAlbumID: post.albumID)
                })
            }
            else
            {
                BlobRequest(withAlbumID: post.albumID).request(
                    onCompletion: { (result: BlobResult) -> Void in
                        if let blob = result.blobs?[safe: 0], let image = UIImage.fromURL(blob.url)
                        {
                            self.blobs[post.albumID] = image
                            self.runOnMainThread({ () -> Void in
                                self.displayCell(cell, withAlbumID: post.albumID)
                            })
                        }
                    },
                    onError: { (error) -> Void in
                        Log.error("Error during BlobRequest(withAlbumID:): \(error)")
                    }
                )
            }
        })
    }
    
    fileprivate func displayCell(_ cell: PostTableViewCell, withAlbumID albumID: String)
    {
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            cell.labelPostName.alpha = 1.0
            cell.labelPrice.alpha = 1.0
            cell.imageChef.alpha = 1.0
            cell.imagePost.alpha = 1.0
            cell.imagePost.image = self.blobs[albumID]
        })
    }
}
