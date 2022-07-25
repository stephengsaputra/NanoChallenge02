//
//  DatabaseIDInputVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 24/07/22.
//

import Foundation
import UIKit

class DatabaseIDInputVC: UIViewController {

    //MARK: - Initializers
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Finally, paste in your Database ID")
        return label
    }()
    
    private lazy var databaseIDTF: AppTextField = {
        let tf = AppTextField(placeholderText: "Database ID")
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var nextButton: AppButton = {
        let button = AppButton(style: .disabled, text: "Next", #selector(handleButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
        
        Utilities().slideViewWhenShowKeyboard(self, #selector(self.keyboardWillShow(notification:)), #selector(self.keyboardWillHide))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        UserDefaults.standard.set(databaseIDTF.text ?? "", forKey: "databaseID")
        navigationController?.pushViewController(NotificationSetupVC(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(headingLabel)
        headingLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 120 : 80,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(databaseIDTF)
        databaseIDTF.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: view.frame.height / 3.4,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(nextButton)
        nextButton.centerX(inView: view)
        nextButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 20
        )
    }
}

extension DatabaseIDInputVC {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpacing = self.view.frame.height - (nextButton.frame.origin.y + nextButton.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpacing + 50
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        
        if textField.text != nil && textField.text!.isEmpty {
            nextButton.isEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.nextButton.backgroundColor = UIColor(named: "disabledButtonBG")
                self.nextButton.setTitleColor(UIColor(named: "disabledButtonText"), for: .normal)
                self.nextButton.alpha = 0.5
            }
        } else {
            nextButton.isEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.nextButton.backgroundColor = .textColor
                self.nextButton.setTitleColor(.backgroundColor, for: .normal)
                self.nextButton.alpha = 1
            }
        }
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        databaseIDTF.resignFirstResponder()
    }
    
    private func configureTextFieldObservers() {
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
}
