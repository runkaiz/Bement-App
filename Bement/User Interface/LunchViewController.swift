//
//  LunchViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 5/23/19.
//  Copyright © 2019 Numeric Design. All rights reserved.
//

import UIKit
import WebKit

class LunchViewController: UIViewController {
    
    @IBOutlet weak var web: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://bementorg.finalsite.com/uploaded/PDF_Links/weeklymenu.pdf")
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
    }
}
