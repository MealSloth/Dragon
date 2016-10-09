//
//  PostDetailTableViewController.swift
//  Dragon
//
//  Created by Michael Fourre on 8/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class PostDetailTableViewController: UITableViewController
{
    var post: Post!
    var blob: UIImage?
    
    // MARK: Delegates
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        
        if self.blob == nil
        {
            if let results = Blob.fromAlbumID(self.post.albumID),
                let first = results[safe: 0]
            {
                self.blob = UIImage.fromURL(first.url)
            }
            else
            {
                BlobRequest(withAlbumID: self.post.albumID).request(
                    onCompletion: { (result: BlobResult) -> Void in
                        if let first = result.blobs?[safe: 0]
                        {
                            self.blob = UIImage.fromURL(first.url)
                        }
                        else
                        {
                            Log.warning("BlobRequest returned nil blob(s)")
                        }
                    },
                    onError: { (error) -> Void in
                        Log.error("Error during BlobRequest: \(error)")
                    }
                )
            }
        }
    }
    
    // MARK: TableView Delegates
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //TODO: Handle row clicks
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailTitleCell", for: indexPath)
            if let titleCell = cell as? PostDetailTitleCell
            {
                titleCell.imagePost.image = self.blob
                return titleCell
            }
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailSummaryCell", for: indexPath)
            if let summaryCell = cell as? PostDetailSummaryCell
            {
                summaryCell.labelName.text = self.post.name
                return summaryCell
            }
            return cell
        }
        else
        {
            Log.error("indexPath.row exceeds expected bounds")
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
