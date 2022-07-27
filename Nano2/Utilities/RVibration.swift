//
//  RVibration.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 27/07/22.
//

import UIKit

class RVibration {
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}
