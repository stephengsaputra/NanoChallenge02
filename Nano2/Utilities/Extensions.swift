//
//  Extensions.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 22/07/22.
//

import UIKit

extension UIColor {
    
    static let textColor = UIColor(named: "textColor")
    static let backgroundColor = UIColor(named: "backgroundColor")
}

extension UIView {
    
    public func setupShadow(
        opacity: Float = 0,
        radius: CGFloat = 0,
        offset: CGSize = .zero,
        color: UIColor = .black) {
        
            layer.shadowOpacity = opacity
            layer.shadowRadius = radius
            layer.shadowOffset = offset
            layer.shadowColor = color.cgColor
    }
    
    convenience public init(backgroundColor: UIColor = .clear) {
        
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }
}

extension UIFont {
    
    static func largeTitle() -> UIFont {
        
        guard let customFont = UIFont(name: "Raleway-Bold", size: 36) else {
            return UIFont.systemFont(ofSize: 36)
        }
        
        return customFont
    }
    
    static func heading() -> UIFont {
        
        guard let customFont = UIFont(name: "Raleway-Bold", size: 32) else {
            return UIFont.systemFont(ofSize: 32)
        }
        
        return customFont
    }
    
    static func subHeading() -> UIFont {
        
        guard let customFont = UIFont(name: "Raleway-Medium", size: 20) else {
            return UIFont.systemFont(ofSize: 20)
        }
        
        return customFont
    }
    
    static func body() -> UIFont {
        
        guard let customFont = UIFont(name: "Raleway-Medium", size: 16) else {
            return UIFont.systemFont(ofSize: 16)
        }
        
        return customFont
    }
    
    static func buttonText() -> UIFont {
        
        guard let customFont = UIFont(name: "Raleway-SemiBold", size: 16) else {
            return UIFont.systemFont(ofSize: 16)
        }
        
        return customFont
    }
    
    static func textField() -> UIFont {
        
        guard let customFont = UIFont(name: "Raleway-Medium", size: 18) else {
            return UIFont.systemFont(ofSize: 20)
        }
        
        return customFont
    }
    
    static func textFieldTitle() -> UIFont {
        
        guard let customFont = UIFont(name: "Raleway-Bold", size: 20) else {
            return UIFont.systemFont(ofSize: 20)
        }
        
        return customFont
    }
}

extension UITextField {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: UIScreen.main.bounds.size.width,
                height: 44.0)
        )
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}

extension UIView {
    
    func pinToParent(parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor)
        ])
    }
    
    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
}
