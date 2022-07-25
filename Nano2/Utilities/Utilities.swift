//
//  Utilities.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 22/07/22.
//

import UIKit

class Utilities {
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
    
    func addNotification() {
        
        let workDays = 2...6
        
        // Create the content
        let content = UNMutableNotificationContent()
        content.title = "Hey, you remember right?"
        content.body = "Don't forget to reflect what you did today!"
        
        for day in workDays {
            
            // Specify the conditions
            var dateComponents = DateComponents()
            dateComponents.weekday = day
            dateComponents.hour = 20
            
            // Create the trigger as a repeating event
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            // Create the request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(
                identifier: uuidString,
                content: content,
                trigger: trigger
            )
            
            // Schedule the request with the system.
            UNUserNotificationCenter.current().add(request) { (error) in
                if error != nil {
                    // Handle any errors.
                }
            }
        }
    }
}
