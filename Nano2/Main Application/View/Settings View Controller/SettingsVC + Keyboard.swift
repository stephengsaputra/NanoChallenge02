//
//  SettingsVC + Keyboard.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 16/09/22.
//

import UIKit

extension SettingsVC {
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        integrationTokenTF.resignFirstResponder()
        databaseIDTF.resignFirstResponder()
    }
    
    func configureTextFieldObservers() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func checkNotification() {
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in

            if settings.authorizationStatus == .authorized {
                print("Push notification is enabled")
                self.check = true
            } else if settings.authorizationStatus == .denied {
                print("Push notification is denied")
                self.check = false
            } else {
                print("Push notification is not enabled")
                self.check = false
            }
        }
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
            UIView.animate(withDuration: 0.5) {
                self.enableNotificationsButton.alpha = 0
            }
        }
        
        alert.addAction(action)
        
        return alert
    }
}
