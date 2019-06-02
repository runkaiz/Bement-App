//
//  MessagesTableViewCell.swift
//  Bement
//
//  Created by Runkai Zhang on 8/19/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    @IBOutlet var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
