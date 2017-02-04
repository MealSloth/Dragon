//
//  HomeViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 7/27/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewController: UITableViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var posts: [Post] = []
    var ratio: CGFloat = 9.0/16.0
    
    // MARK: Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        
        self.posts = Post.sortBy(key: "postTime", ascending: false) ?? []
        self.refresh()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue_HomeTableViewController->PostDetailTableViewController",
            let vc = segue.destination as? PostDetailTableViewController,
            let post = sender as? Post {
            vc.post = post
        }
    }
    
    // MARK: TableView Delegates
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.posts.count == 0 ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.posts.count == 0 ? 0.0 : ScreenHelper.screenWidth * self.ratio + 50.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath)
        guard let postCell = cell as? PostTableViewCell else { return cell }
        guard let post = self.posts[safe: indexPath.row] else { return postCell }
        postCell.populate(withPost: post)
        return postCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = self.posts[safe: indexPath.row] else { return }
        self.segue(withPost: post)
    }
    
    // MARK: Misc
    func refresh() {
        PostPageRequest().request(
            onCompletion: { (result: PostPageResult) -> Void in
                //Query and compare on background thread
                let newPosts = Post.sortBy(key: "postTime", ascending: false) ?? []
                let changes = self.posts != newPosts
                //Then perform UI tasks on main thread
                self.runOnMainThread({ () -> Void in
                    if changes {
                        self.posts = newPosts //Update
                        self.tableView.reloadData() //and reload
                    }
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
    
    fileprivate func segue(withPost post: Post) {
        self.performSegue(withIdentifier: "Segue_HomeTableViewController->PostDetailTableViewController", sender: post)
    }
}
