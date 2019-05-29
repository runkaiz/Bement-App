//
//  InstagramTableViewCell.swift
//  Bement
//
//  Created by Runkai Zhang on 5/27/19.
//  Copyright © 2019 Numeric Design. All rights reserved.
//

import UIKit

class InstagramWithImageTableViewCell: UITableViewCell {

    @IBOutlet var dateOfPub: UILabel!
    @IBOutlet var contentImage: UIImageView!
    @IBOutlet var content: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
