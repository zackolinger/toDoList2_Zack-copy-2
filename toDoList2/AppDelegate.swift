//
//  AppDelegate.swift
//  toDoList2
//
//  Created by Zack Olinger on 4/10/18.
//  Copyright © 2018 Zack Olinger. All rights reserved.
//

import UIKit
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let splitViewController =  UISplitViewController()
        let rootViewController = ViewController()
        let detailViewController = DetailsController()
        
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        let detailNavigationController = UINavigationController(rootViewController: detailViewController)
        rootNavigationController.isNavigationBarHidden = true
        
        splitViewController.viewControllers = [rootNavigationController, detailNavigationController]
        splitViewController.preferredDisplayMode = .allVisible
        
        self.window!.rootViewController = splitViewController
        self.window!.makeKeyAndVisible()
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (accepted, error) in   }
        } else {
            
        }
        
        return true
    }

    static func saveTasks(tasks: [Task]) {
        var dictToAppendToSave: [[String: Any]] = []
        
        for task in tasks {
            let task_Name = task.task, color = task.color, createdAt = task.createdAt as NSDate, hasFinished = task.isDone, detail = (task.details.isEmpty) ? "No Details" : task.details
            var notification_Time: String {
                if task.notificationTime != nil {
                    return "\(String(describing: task.notificationTime))"
                }
                return "nil"
            }
            
            dictToAppendToSave.append(["task": task_Name, "detail": detail, "color": color, "createdAt": createdAt as Any, "isDone": hasFinished, "notificationTime": notification_Time])
        }
        UserDefaults.standard.set(dictToAppendToSave, forKey: "savedTasks")
    }

    func loadTasks() {
        
        if let array = UserDefaults.standard.object(forKey: "savedTasks") as? [[String: Any]]  {
            for i in 0 ..< array.count {
                
                let task = array[i]["task"] as! String
                var detail: String! {
                    if (array[i]["detail"] != nil) {
                        return array[i]["detail"] as? String
                    } else {
                        return "No Details"
                    }
                }
                let color = array[i]["color"] as! String
                let createdAt: Date = array[i]["createdAt"] as! Date
                let isDone = array[i]["isDone"] as! Bool
                var notificationTime: Date? {
                    if (array[i]["notificationTime"] != nil) {
                        return array[i]["notificationTime"] as? Date
                    } else {
                        return nil
                    }
                }
                let taskLoaded = Task(task: task, details: detail, createdAt: createdAt, color: color, isDone: isDone, notificationTime: notificationTime)
                ViewController.TASKS_ARRAY.append(taskLoaded)
            }
        }
    }
    

    
    static func fireUpLocalNotifications(at date: Date, task: String) {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        if #available(iOS 10.0, *) {
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            
            let content = UNMutableNotificationContent()
            content.title = "My To-Do-List App"
            content.body = task
            content.sound = UNNotificationSound.default()
            
            //here the official launching and firing of the notification
            let request = UNNotificationRequest(identifier: task, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) {(error) in
                if error != nil {
                    //print("Uh oh! We had an error: \(error)")
                }
            }
        } else {   /* Fallback on earlier versions */    }
    }
    
    
    static func removeSpecificLocalNotification(withIdentifier task: String) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                for notification:UNNotificationRequest in notificationRequests {
                    if notification.identifier == task {
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [task])
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
//============================================================================================
//============================================================================================
    
    
    
}


 
 
 


