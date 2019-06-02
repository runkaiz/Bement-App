//
//  ForgotViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/8/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit

class ForgotViewController: UIViewController {

    @IBOutlet var contactSchool: UIButton!
    @IBOutlet var warning: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.beautifulButton(contactSchool)
        warning.text = NSLocalizedString("forgotPasswordWarning", comment: "")
    }

    @IBAction func contactSchool(_ sender: Any) {
        let url = URL(string: "TEL://4137747061")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}
