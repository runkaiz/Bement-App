//
//  InquiryViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 7/16/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import MessageUI

class InquiryViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var streetField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var stateField: UITextField!
    @IBOutlet var countryField: UITextField!
    @IBOutlet var applyField: UITextField!
    @IBOutlet var currentField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tools.beautifulButton(sendButton)
    }

    @IBAction func sendClicked(_ sender: Any) {
        
        if nameField.text?.replacingOccurrences(of: " ", with: "") != "" || emailField.text?.replacingOccurrences(of:" ", with: "") != "" || phoneField.text?.replacingOccurrences(of:" ", with: "") != "" || streetField.text?.replacingOccurrences(of:" ", with: "") != "" || cityField.text?.replacingOccurrences(of:" ", with: "") != "" || stateField.text?.replacingOccurrences(of:" ", with: "") != "" || countryField.text?.replacingOccurrences(of:" ", with: "") != "" || applyField.text?.replacingOccurrences(of:" ", with: "") != "" || currentField.text?.replacingOccurrences(of:" ", with: "") != "" {
            
            let message = """
                        <h1>Inquiry Submission</h1>
                        <p>My name is \(nameField.text ?? "") and here is my information for the inquiry:</p>
                        <p>Email: \(emailField.text ?? "")</p>
                        <p>Phone number: \(phoneField.text ?? "")</p>
                        <p>Address:</p>
                        <p>\(streetField.text ?? "")</p>
                        <p>\(cityField.text ?? "")</p>
                        <p>\(stateField.text ?? "")</p>
                        <p>\(countryField.text ?? "")</p>
                        <p>I am apply for \(applyField.text ?? "") and my current grade is \(currentField.text ?? "")</p>
                        """
            sendEmail(with: message)
        } else {
            let alert = UIAlertController(title: "Error", message: "You must fill all the fields!", preferredStyle: .alert)
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func sendEmail(with input: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody(input, isHTML: true)
            
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
