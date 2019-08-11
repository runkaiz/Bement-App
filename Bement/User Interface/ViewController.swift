//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import SwiftyJSON
import CloudKit

class ViewController: UIViewController {
    
    private var observer: NSObjectProtocol?
    
    var originalLocation: CGFloat?
    var originalLocationMoved: CGFloat?
    
    @IBOutlet var socialButton: UIButton!
    @IBOutlet var calendersButton: UIButton!
    @IBOutlet var lunchButton: UIButton!
    @IBOutlet var reportsButton: UIButton!
    @IBOutlet var supportButton: UIButton!
    @IBOutlet var hourTitle: UILabel!
    @IBOutlet var startHour: UILabel!
    @IBOutlet var endHour: UILabel!
    @IBOutlet var data: UIButton!
    @IBOutlet var identity: UIButton!
    @IBOutlet var admin: UIButton!
    
    var button: HamburgerButton! = nil
    @IBOutlet var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tools.beautifulButton(supportButton)
        tools.beautifulButton(reportsButton)
        tools.beautifulButton(lunchButton)
        tools.beautifulButton(calendersButton)
        tools.beautifulButton(socialButton)
        
        fetchData()
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { notification in
            self.fetchData()
        }

        originalLocationMoved = data.center.x
        originalLocation = data.center.x - view.bounds.width
        
        button = HamburgerButton(frame: CGRect(x: 0, y: 0, width: 54, height: 54))
        button.addTarget(self, action: #selector(toggle(_:)), for:.touchUpInside)
                                
        buttonView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: buttonView.topAnchor),
                button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
                button.leftAnchor.constraint(equalTo: buttonView.leftAnchor),
                button.rightAnchor.constraint(equalTo: buttonView.rightAnchor),
                button.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor)
        ])
    }
    
    func fetchData() {
        let publicDatabase = CKContainer.default().publicCloudDatabase
        let recordID = CKRecord.ID(recordName: "0")
        publicDatabase.fetch(withRecordID: recordID, completionHandler: { record, error in
            if error != nil {
                DispatchQueue.main.sync {
                    self.hourTitle.text = "They are no special"
                    self.startHour.text = "announcements at this moment."
                    self.endHour.text = ""
                }
            } else {
                if Bool(truncating: (record!["display"] as! Int) as NSNumber) == true {
                    DispatchQueue.main.sync {
                        self.hourTitle.text = record!["titleString"]
                        self.startHour.text = record?["firstLine"] ?? ""
                        self.endHour.text = record?["secondLine"] ?? ""
                    }
                } else {
                    DispatchQueue.main.sync {
                        self.hourTitle.text = "They are no special"
                        self.startHour.text = "announcements at this moment."
                        self.endHour.text = ""
                    }
                }
            }
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
        adjustMenuItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
        adjustMenuItem()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        adjustMenuItem()
        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        
        if userInterfaceStyle == .dark {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = .white
        }
    }
    
    @objc func toggle(_ sender: AnyObject!) {
        
        adjustMenuItem()
        button.showsMenu = !button.showsMenu
        
        if button.showsMenu {
            UIView.animate(withDuration: 0.3) {
                self.data.center.x += self.view.bounds.width
                self.data.alpha = 1
            }
            UIView.animate(withDuration: 0.4) {
                self.identity.center.x += self.view.bounds.width
                self.identity.alpha = 1
            }
            UIView.animate(withDuration: 0.5) {
                self.admin.center.x += self.view.bounds.width
                self.admin.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.data.center.x -= self.view.bounds.width
                self.data.alpha = 0
            }
            UIView.animate(withDuration: 0.4) {
                self.identity.center.x -= self.view.bounds.width
                self.identity.alpha = 0
            }
            UIView.animate(withDuration: 0.5) {
                self.admin.center.x -= self.view.bounds.width
                self.admin.alpha = 0
            }
        }
    }
    
    @IBAction func backToMain(_ unwindSegue: UIStoryboardSegue) {
        fetchData()
        adjustMenuItem()
        
        UIView.animate(withDuration: 0.4) {
            self.socialButton.transform = CGAffineTransform.identity
            self.calendersButton.transform = CGAffineTransform.identity
            self.lunchButton.transform = CGAffineTransform.identity
            self.reportsButton.transform = CGAffineTransform.identity
            self.supportButton.transform = CGAffineTransform.identity
        }
    } 
    
    func isAppAlreadyLaunchedOnce()-> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            //print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            //print("App launched first time")
            return false
        }
    }
    
    func adjustMenuItem() {
        //print("Adjusted")
        if button.showsMenu {
            self.data.center.x = originalLocationMoved!
            self.identity.center.x = originalLocationMoved!
            self.admin.center.x = originalLocationMoved!
            self.data.alpha = 1
            self.identity.alpha = 1
            self.admin.alpha = 1
        } else {
            self.data.center.x = originalLocation!
            self.identity.center.x = originalLocation!
            self.admin.center.x = originalLocation!
            self.data.alpha = 0
            self.identity.alpha = 0
            self.admin.alpha = 0
        }
    }
    
    @IBAction func touchedDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
        completion: { _ in  })
    }
    
    @IBAction func touchExit(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.transform = CGAffineTransform.identity
        }
    }
}
