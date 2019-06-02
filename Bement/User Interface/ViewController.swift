//
//  LoginViewController.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, ATCWalkthroughViewControllerDelegate {
    
    private var observer: NSObjectProtocol?
    
    @IBOutlet var socialButton: UIButton!
    @IBOutlet var calendersButton: UIButton!
    @IBOutlet var lunchButton: UIButton!
    @IBOutlet var reportsButton: UIButton!
    @IBOutlet var supportButton: UIButton!
    @IBOutlet var hourTitle: UILabel!
    @IBOutlet var startHour: UILabel!
    @IBOutlet var endHour: UILabel!
    
    let walkthroughs = [
        ATCWalkthroughModel(title: "Efficienct Login System", subtitle: "This login system is very user-friendly and 100% secure when handling your data.", icon: "Real"),
        ATCWalkthroughModel(title: "Quick Responses", subtitle: "This system have lightning respond time and can provide you first hand data withour delay.", icon: "lighting"),
        ATCWalkthroughModel(title: "Calender Feeds", subtitle: "Extremely convenient calender system by using Apple's native calender app, keeping you up to date.", icon: "Straight"),
        ATCWalkthroughModel(title: "Get Notified", subtitle: "Receive notifications when a term report is released to stay on top of everything.", icon: "bell"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.getSchoolHours()
        
        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { notification in
            self.getSchoolHours()
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
        //print("Popping back to this view controller!")
        // reset UI elements etc here
    }
    
    @IBAction func support(_ sender: Any) {
        globalVariable.firstTimeIndicator = true
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
        return ATCWalkthroughViewController(nibName: "ATCWalkthroughViewController",
                                            bundle: nil,
                                            viewControllers: viewControllers)
    }
}
