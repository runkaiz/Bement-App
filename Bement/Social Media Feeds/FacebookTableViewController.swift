//
//  FacebookTableViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/26/19.
//  Copyright © 2019 Numeric Design. All rights reserved.
//

import UIKit
import Kingfisher
import AlamofireRSSParser
import Fuzi

class FacebookTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 450
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AppDelegate.facebookItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let datePub = formatter.string(from: AppDelegate.facebookItems[indexPath.row].pubDate!)
        
        let cellWithImage = tableView.dequeueReusableCell(withIdentifier: "cellWithImage", for: indexPath) as! FacebookWithImageTableViewCell
        let cellWithoutImage = tableView.dequeueReusableCell(withIdentifier: "cellWithoutImage", for: indexPath) as! FacebookWithoutImageTableViewCell
        
        let url = URL(string: "\(AppDelegate.facebookItems[indexPath.row].imagesFromDescription!.first!)?_nc_ht=scontent-iad3-1.xx.fbcdn.net")
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
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        if AppDelegate.facebookItems[indexPath.row].imagesFromDescription != nil {
            cellWithImage.dateOfPub.text = "Date: \(datePub)"
            
            do {
                let html = AppDelegate.facebookItems[indexPath.row].itemDescription!
                let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
                let actualText = String(describing: doc.body!.children[0].children[1])
                let startIndex = actualText.index(actualText.startIndex, offsetBy: 5)
                let lastIndex = actualText.index(actualText.endIndex, offsetBy: -6)
                let processedText = Range(uncheckedBounds: (lower: startIndex, upper: lastIndex))
                cellWithImage.content.text = "\(actualText[processedText])"
            } catch let error {
                print(error)
            }
            
            return cellWithImage
        } else {
            cellWithoutImage.dateOfPub.text = "Date: \(datePub)"
            
            do {
                let html = AppDelegate.facebookItems[indexPath.row].itemDescription!
                let doc = try HTMLDocument(string: html, encoding: String.Encoding.utf8)
                cellWithoutImage.content.text = "\(String(describing: doc.body!.children[0].children[1]))"
            } catch let error {
                print(error)
            }
            
            return cellWithoutImage
        }
    }
}
