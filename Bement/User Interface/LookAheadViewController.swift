//
//  LookAheadViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 11/27/18.
//  Copyright © 2018 Numeric Design. All rights reserved.
//

import UIKit
import WebKit

class LookAheadViewController: UIViewController {

    @IBOutlet weak var web: WKWebView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:"https://bementorg.finalsite.com/cf_enotify/view.cfm?n=1581")
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
    }
}
