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
    var ratio: CGFloat = 9.0/16.0
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        
        if let posts = Post.sortBy(key: "postTime", ascending: false)
        {
            self.posts = posts
            self.tableView.performSelector(onMainThread: #selector(self.tableView.reloadData), with: nil, waitUntilDone: false)
        }
        else
        {
            self.refresh()
        }
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
        if segue.identifier == "Segue_HomeTableViewController->PostDetailTableViewController",
            let vc = segue.destination as? PostDetailTableViewController,
            let post = sender as? Post
        {
            vc.post = post
        }
    }
    
    // MARK: TableView Delegates
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.posts.count == 0 ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return self.posts.count == 0 ? 0.0 : ScreenHelper.screenWidth * self.ratio + 50.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else
        {
            Log.warning("Failed cast to PostTableViewCell")
            return self.tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)
        }
        
        guard let post = self.posts[safe: indexPath.row] else
        {
            Log.error("Missing post for PostTableViewCell at row \(indexPath.row) in section \(indexPath.section)")
            return self.tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)
        }
        
        cell.populate(withPost: post)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let post = self.posts[safe: indexPath.row]
        {
            self.segue(withPost: post)
        }
    }
    
    // MARK: Misc
    func refresh()
    {
        PostPageRequest().request(
            onCompletion: { (result: PostPageResult) -> Void in
                self.runOnMainThread({ () -> Void in
                    self.posts = Post.sortBy(key: "postTime", ascending: false) ?? []
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
            },
            onError: { (error) -> Void in
                Log.error("Error occurred during PostPageRequest(): \(error)")
                self.runOnMainThread({ () -> Void in
                    self.refreshControl?.endRefreshing()
                })
            }
        )
    }
    
    fileprivate func segue(withPost post: Post)
    {
        self.performSegue(withIdentifier: "Segue_HomeTableViewController->PostDetailTableViewController", sender: post)
    }
}
