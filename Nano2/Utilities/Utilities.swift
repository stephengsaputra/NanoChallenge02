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
}
