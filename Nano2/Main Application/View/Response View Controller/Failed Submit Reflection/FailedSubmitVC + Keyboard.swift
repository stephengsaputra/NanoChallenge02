//
//  FailedSubmitVC + Keyboard.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 16/09/22.
//

import UIKit

extension FailedSubmitVC {
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        
        if textField.text != nil && textField.text!.isEmpty {
            backToSummaryButton.isEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.backToSummaryButton.backgroundColor = UIColor(named: "disabledButtonBG")
                self.backToSummaryButton.setTitleColor(UIColor(named: "disabledButtonText"), for: .normal)
                self.backToSummaryButton.alpha = 0.5
            }
        } else {
            backToSummaryButton.isEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.backToSummaryButton.backgroundColor = .textColor
                self.backToSummaryButton.setTitleColor(.backgroundColor, for: .normal)
                self.backToSummaryButton.alpha = 1
            }
        }
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        integrationTokenTF.resignFirstResponder()
        databaseIDTF.resignFirstResponder()
    }
    
    func configureTextFieldObservers() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
}
