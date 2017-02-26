//
//  HomeViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 7/27/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewController: UITableViewController, RefreshControllable {
    var posts: [Post] = []
    var ratio: CGFloat = 9.0/16.0
    
    // MARK: Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib(withName: "PostTableViewCell")
        self.posts = Post.sorted ?? []
        self.addRefreshControl()
        self.refresh()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
            case "Segue_HomeTableViewController->PostDetailTableViewController":
                (segue.destination as? PostDetailTableViewController)?.post = sender as? Post
                break
            default:
                break
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
        (cell as? PostTableViewCell)?.populate(with: self.posts[safe: indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let post = self.posts[safe: indexPath.row] else { return }
        self.segue(with: post)
    }
    
    // MARK: Misc
    func refresh() {
        PostPageRequest().request(
            onCompletion: { (result) -> Void in
                self.posts = Post.sortBy(key: "postTime", ascending: false) ?? []
                self.reload(animated: false)
            },
            onError: { (error) -> Void in
                Log.error("Error occurred during PostPageRequest(): \(error)")
            },
            finally: { () -> Void in
                self.endRefreshing()
            }
        )
    }
    
    fileprivate func segue(with post: Post) {
        self.segue(withIdentifier: "Segue_HomeTableViewController->PostDetailTableViewController", sender: post)
    }
}
