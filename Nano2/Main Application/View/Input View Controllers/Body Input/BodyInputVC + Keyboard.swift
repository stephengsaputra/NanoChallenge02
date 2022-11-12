//
//  BodyInputVC + Keyboard.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 27/07/22.
//

import UIKit

extension BodyInputVC {
    
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
