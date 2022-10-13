//
//  LoalNotificationViewController.swift
//  tableViewCellDeleteAction
//
//  Created by Piyush Naranje on 11/04/22.
//

import UIKit
import UserNotifications
class LoalNotificationViewController: UIViewController , UNUserNotificationCenterDelegate{

    let notificationCentre = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCentre.delegate = self
        notificationCentre.requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
        }
    }
//.p12 .p8
    @IBAction func btnLocalNotificationClickAction(_ sender: UIButton) {
//        create content for notification
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "my category indentifier"
        content.title = "Local Notification Task"
        content.body = "I have created an example of Local Notification Task"
        content.badge = 1
        content.sound = UNNotificationSound.default
//        notificationImg
        let url = Bundle.main.url(forResource: "nature", withExtension: "jpeg")
        let attachment = try! UNNotificationAttachment(identifier: "image", url: url!, options: [:])
        content.attachments = [attachment]
//        create notification trigger
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 6, repeats: false)
        let identifier = "main Indentifier"
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        notificationCentre.add(request){ (error) in
//            print("\(error?.localizedDescription)")
        }
//        NotificationAction
        
        let open = UNNotificationAction.init(identifier: "Open", title: "Open", options: .foreground)
        let delete = UNNotificationAction.init(identifier: "Delete", title: "Delete", options: .destructive)
        let category  = UNNotificationCategory.init(identifier: content.categoryIdentifier, actions: [open,delete], intentIdentifiers: [], options: [])
        notificationCentre.setNotificationCategories([category])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}
