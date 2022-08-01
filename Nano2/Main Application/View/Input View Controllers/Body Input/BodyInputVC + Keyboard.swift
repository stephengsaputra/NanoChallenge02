//
//  BodyInputVC + Keyboard.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 27/07/22.
//

import UIKit

extension BodyInputVC {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpacing = self.view.frame.height - (headingLabel.frame.origin.y + textView.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpacing
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        
        textView.resignFirstResponder()
        
        if textView.text != nil && textView.text!.isEmpty {
            UIView.animate(withDuration: 0.2) {
                self.finishButton.isEnabled = false
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.finishButton.isEnabled = true
            }
        }
    }
    
    internal func configureTextViewObservers() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
}
