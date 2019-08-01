//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Firebase

class ViewController: UIViewController, ATCWalkthroughViewControllerDelegate {
    
    private var observer: NSObjectProtocol?
    
    var remoteConfig: RemoteConfig!
    
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
    
    var button: HamburgerButton! = nil
    @IBOutlet var buttonView: UIView!
    
    let walkthroughs = [
        ATCWalkthroughModel(title: "Efficienct Login System", subtitle: "This login system is very user-friendly and 100% secure when handling your data.", icon: "Real"),
        ATCWalkthroughModel(title: "Quick Responses", subtitle: "This system have lightning respond time and can provide you first hand data withour delay.", icon: "lighting"),
        ATCWalkthroughModel(title: "Calender Feeds", subtitle: "Extremely convenient calender system by using Apple's native calender app, keeping you up to date.", icon: "Straight"),
        ATCWalkthroughModel(title: "Get Notified", subtitle: "Receive notifications when a term report is released to stay on top of everything.", icon: "bell"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        fetchConfig()
        
        if isAppAlreadyLaunchedOnce() == false {
            let walkthroughVC = self.walkthroughVC()
            walkthroughVC.delegate = self
            self.addChildViewControllerWithView(walkthroughVC)
        }
        
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
        let myCalendar = Calendar(identifier: .gregorian)
        let month = myCalendar.component(.month, from: Date())
        let day = myCalendar.component(.day, from: Date())
                    
        if month >= 6 && month <= 8 {
            if month == 6 {
                if day >= 7 {
                    self.hourTitle.text = "There is no school tomorrow."
                    self.startHour.text = "Have a great summer!"
                    self.endHour.isHidden = true
                } else {
                    self.getSchoolHours()
                }
            } else {
                self.hourTitle.text = "There is no school tomorrow."
                self.startHour.text = "Have a great summer!"
                self.endHour.isHidden = true
            }
        } else {
            self.getSchoolHours()
        }
    }
    
    private func fetchConfig() {
        let isSnowDay = remoteConfig["snow_day_enabled"].boolValue
        
        remoteConfig.fetch() { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            self.remoteConfig.activate(completionHandler: { (error) in
                if isSnowDay {
                    DispatchQueue.main.sync {
                        self.hourTitle.text = "Tomorrow is a snow day."
                        self.startHour.text = "Stay safe!"
                        self.endHour.isHidden = true
                    }
                }
            })
          } else {
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchConfig()
        adjustMenuItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        //print("Toggle")
        adjustMenuItem()
        button.showsMenu = !button.showsMenu
        
        if button.showsMenu {
            UIView.animate(withDuration: 0.4) {
                self.data.center.x += self.view.bounds.width
                self.data.alpha = 1
                // print(self.data.center.x)
            }
            UIView.animate(withDuration: 0.5) {
                self.identity.center.x += self.view.bounds.width
                self.identity.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.data.center.x -= self.view.bounds.width
                self.data.alpha = 0
                // print(self.data.center.x)
            }
            UIView.animate(withDuration: 0.4) {
                self.identity.center.x -= self.view.bounds.width
                self.identity.alpha = 0
            }
        }
    }
    
    func getSchoolHours() {
        var request = URLRequest(url: URL(string: "http://207.246.85.80:3000/time")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        if self.getDayOfWeek(Date()) == 7 || self.getDayOfWeek(Date()) == 6 {
            self.hourTitle.text = "There is no school tomorrow."
            self.startHour.text = "Have a great day!"
            self.endHour.isHidden = true
        } else {
            session.dataTask(with: request) {data, response, err in
                DispatchQueue.main.async {
                    do {
                        self.hourTitle.isHidden = false
                        self.startHour.isHidden = false
                        self.endHour.isHidden = false
                        
                        let formatter = DateFormatter()
                        formatter.dateStyle = .short
                        let today = Date()
                        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
                        let date = formatter.string(from: tomorrow!)
                        
                        self.hourTitle.text = "School hours for \(date):"
                        let json = try JSON(data: data!)
                        if let start = json["startTime"].string {
                            self.startHour.text = "Starts at \(start)"
                            if let end = json["endTime"].string {
                                self.endHour.text = "Dismisses at \(end)"
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func getDayOfWeek(_ date:Date) -> Int? {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        return weekDay
    }
    
    @IBAction func done(_ segue: UIStoryboardSegue) {
       adjustMenuItem()
    } 
    
    func isAppAlreadyLaunchedOnce()-> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            //print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            //print("App launched first time")
            return false
        }
    }
    
    func walkthroughViewControllerDidFinishFlow(_ vc: ATCWalkthroughViewController) {
        UIView.transition(with: self.view, duration: 1, options: .transitionFlipFromLeft, animations: {
            vc.view.removeFromSuperview()
            let viewControllerToBePresented = UIViewController()
            self.view.addSubview(viewControllerToBePresented.view)
        }, completion: nil)
    }
    
    fileprivate func walkthroughVC() -> ATCWalkthroughViewController {
        let viewControllers = walkthroughs.map { ATCClassicWalkthroughViewController(model: $0, nibName: "ATCClassicWalkthroughViewController", bundle: nil) }
        return ATCWalkthroughViewController(nibName: "ATCWalkthroughViewController", bundle: nil, viewControllers: viewControllers)
    }
    
    func adjustMenuItem() {
        //print("Adjusted")
        if button.showsMenu {
            self.data.center.x = originalLocationMoved!
            self.identity.center.x = originalLocationMoved!
            self.data.alpha = 1
            self.identity.alpha = 1
        } else {
            self.data.center.x = originalLocation!
            self.identity.center.x = originalLocation!
            self.data.alpha = 0
            self.identity.alpha = 0
        }
    }
}
