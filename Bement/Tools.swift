//
//  Functions.swift
//  Bement
//
//  Created by Runkai Zhang on 8/7/18.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class tools {
    
    /**
     Adding a `cornerRadius` of **15** onto a `UIButton` to encourage global styling.
    
     ```swift
    tools.beautifulButton(someButton)
     ```
     Is all you need to do to implement this.
     
     - parameters:
        - object: `UIButton` that you are trying to modify.
    */
    public static func beautifulButton(_ object:UIButton) {
        object.layer.cornerRadius = 15
        object.layer.masksToBounds = true
    }
    
    /**
     Push a highly configurable notification.
     If you want to push a scheduled notification use `pushScheduled()`.
     - parameters:
        - title: The title of the notification.
        - subtitle: The subtitle of the notification.
        - body: The body of the notification.
        - sound: The sound of the notification.
        - triggerInterval: The amount of time before the notification is triggered.
        - repeating: Whether you want it to repeat by the `triggerInterval`.
        - id: The id of the notification.
    */
    public static func push(title:String, subtitle:String, body:String, sound:UNNotificationSound, triggerInterval:TimeInterval, repeating:Bool, id:String) {
        
        //get the notification center
        let center =  UNUserNotificationCenter.current()
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        
        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:triggerInterval, repeats: repeating)
        
        //create request to display
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    /**
     Push a highly configurable and scheduled notification.
     - parameters:
        - title: The title of the notification.
        - subtitle: The subtitle of the notification.
        - body: The body of the notification.
        - sound: The sound of the notification.
        - date: When the notification are scheduled to be triggered.
        - repeating: Whether you want it to repeat by the `triggerInterval`.
        - id: The id of the notification.
    */
    public static func pushScheduled(title:String, subtitle:String, body:String, sound:UNNotificationSound, date:DateComponents, repeating:Bool, id:String) {
        
        //get the notification center
        let center =  UNUserNotificationCenter.current()
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        
        //notification trigger can be based on time, calendar or location
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeating)
        
        //create request to display
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    public static func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hr
        components.minute = min
        components.second = sec
        let date = calendar.date(from: components as DateComponents)
        return date! as NSDate
    }
    
    public static func component2Date(_ component: DateComponents) -> NSDate {
        let calender = NSCalendar(calendarIdentifier: .gregorian)
        let date = calender?.date(from: component)
        return date! as NSDate
    }
}
