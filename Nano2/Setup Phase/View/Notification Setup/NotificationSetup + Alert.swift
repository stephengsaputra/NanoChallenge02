//
//  NotificationSetup + Alert.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 27/07/22.
//

import UIKit

extension NotificationSetupVC {
    
    func pushAlertTwoAction() -> UIViewController {
        
        let alert = UIAlertController(
            title: "Are you sure?",
            message: "This application will not be able to remind you to write your Reflections.",
            preferredStyle: .alert
        )
        alert.view.tintColor = UIColor.textColor
        
        let action1 = UIAlertAction(title: "Yes", style: .cancel) { action in
            self.present(self.noThanksAlert(), animated: true)
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .default) { action in
            self.dismiss(animated: true)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        return alert
    }
    
    func doNotAllowAlert() -> UIViewController {
        
        let alert = UIAlertController(
            title: "Reminders Not Allowed!",
            message: "If this is an accident, you can turn on the notifications in Settings.",
            preferredStyle: .alert
        )
        alert.view.tintColor = UIColor.textColor
        
        let action = UIAlertAction(title: "Alrighty!", style: .cancel) { action in
            self.dismiss(animated: true)
            self.navigationController?.pushViewController(FinishSetupVC(), animated: true)
        }
        
        alert.addAction(action)
        
        return alert
    }
    
    func noThanksAlert() -> UIViewController {
        
        let alert = UIAlertController(
            title: "Reminders Disabled!",
            message: "If you do change your mind, you can always enable it in the Settings page.",
            preferredStyle: .alert
        )
        alert.view.tintColor = UIColor.textColor
        
        let action = UIAlertAction(title: "Alrighty!", style: .cancel) { action in
            self.dismiss(animated: true)
            self.navigationController?.pushViewController(FinishSetupVC(), animated: true)
        }
        
        alert.addAction(action)
        
        return alert
    }
}
