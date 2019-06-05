//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContactBementViewController: UIViewController {
    
    @IBOutlet var inquireButton: UIButton!
    @IBOutlet var contactButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tools.beautifulButton(inquireButton)
        tools.beautifulButton(contactButton)
    }
}
