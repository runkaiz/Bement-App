//
//  TwitterTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/26/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import Kingfisher
import AlamofireRSSParser
import Fuzi

class TwitterTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppDelegate.twitterItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let datePub = formatter.string(from: AppDelegate.twitterItems[indexPath.row].pubDate!)
        
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! TwitterWithImageTableViewCell
        let cellWithoutImage = tableView.dequeueReusableCell(withIdentifier: "cellWithoutImage", for: indexPath) as! TwitterWithoutImageTableViewCell
        
        if AppDelegate.twitterItems[indexPath.row].enclosures![0]["url"] != nil {
            let url = URL(string: AppDelegate.twitterItems[indexPath.row].enclosures![0]["url"]!)
            let processor = DownsamplingImageProcessor(size: cellWithImage.contentImage.frame.size)
                >> RoundCornerImageProcessor(cornerRadius: 15)
            cellWithImage.contentImage.kf.indicatorType = .activity
            cellWithImage.contentImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
            ]) { result in
                
            }
            
            cellWithImage.dateOfPub.text = "Date: \(datePub)"
            cellWithImage.content.text = AppDelegate.twitterItems[indexPath.row].title
            
            return cellWithImage
        } else {
            cellWithoutImage.dateOfPub.text = "Date: \(datePub)"
            cellWithoutImage.content.text = AppDelegate.twitterItems[indexPath.row].title
            
            return cellWithoutImage
        }
    }
}
