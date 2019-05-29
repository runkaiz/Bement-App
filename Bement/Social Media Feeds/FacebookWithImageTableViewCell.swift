//
//  FacebookTableViewCell.swift
//  Bement
//
//  Created by Runkai Zhang on 5/26/19.
//  Copyright © 2019 Numeric Design. All rights reserved.
//

import UIKit

class FacebookWithImageTableViewCell: UITableViewCell {

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
