//
//  DatabaseIDInputVCExtenstion.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 27/07/22.
//

import UIKit

extension DatabaseIDInputVC {
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        
        if textField.text != nil && textField.text!.isEmpty {
            UIView.animate(withDuration: 0.2) {
                self.nextButton.isEnabled = false
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.nextButton.isEnabled = true
            }
        }
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        databaseIDTF.resignFirstResponder()
    }
    
    internal func configureTextFieldObservers() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
}
