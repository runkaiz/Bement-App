//
//  SpeedContactViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 6/23/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import MessageUI

class SpeedContactViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var constaCard: UIView!
    @IBOutlet var constaPhone: UIButton!
    @IBOutlet var constaEmail: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constaCard.layer.cornerRadius = 15
        
        constaPhone.layer.cornerRadius = 7
        constaEmail.layer.cornerRadius = 7
    }
    
    @IBAction func constaPhoneClicked(_ sender: Any) {
        guard let number = URL(string: "tel://") else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func constaEmailClicked(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["tcosta@bement.org"])
            mail.setMessageBody("", isHTML: false)
            
            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Your device cannot send emails.", preferredStyle: .alert)
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
