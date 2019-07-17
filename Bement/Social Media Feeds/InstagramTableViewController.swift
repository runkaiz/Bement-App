//
//  InstagramTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/27/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import Kingfisher
import AlamofireRSSParser

class InstagramTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppDelegate.instagramItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let datePub = formatter.string(from: AppDelegate.instagramItems[indexPath.row].pubDate!)
        
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! InstagramWithImageTableViewCell
        
        let url = URL(string: "\(AppDelegate.instagramItems[indexPath.row].imagesFromDescription!.first!)?_nc_ht=scontent-iad3-1.cdninstagram.com")
        let processor = DownsamplingImageProcessor(size: cellWithImage.contentImage.frame.size)
            >> RoundCornerImageProcessor(cornerRadius: 15)
        cellWithImage.contentImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale)
            ])
        {
            result in
            
        }
        
        cellWithImage.dateOfPub.text = "Date: \(datePub)"
        cellWithImage.content.text = AppDelegate.instagramItems[indexPath.row].title!
        
        return cellWithImage
    }
}
