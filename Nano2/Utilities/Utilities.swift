//
//  Utilities.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 22/07/22.
//

import UIKit

class Utilities {
    
    func slideViewWhenShowKeyboard(_ target: Any, _ actionShowKeyboard: Selector, _ actionHideKeyboard: Selector) {
        
        NotificationCenter.default.addObserver(target, selector: actionShowKeyboard, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(target, selector: actionHideKeyboard, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
