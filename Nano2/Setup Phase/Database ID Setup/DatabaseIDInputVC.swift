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
        let tf = AppTextField(placeholderText: "Integration Token")
        return tf
    }()
    
    private lazy var nextButton: AppButton = {
        let button = AppButton(style: .disabled, text: "Next")
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        
        databaseIDTF.delegate = self
        databaseIDTF.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        navigationController?.pushViewController(NotificationSetupVC(), animated: true)
    }
    
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

extension DatabaseIDInputVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        
        if textField.text != nil && textField.text!.isEmpty {
            // nextButton becomes .disabled
        } else {
            nextButton.isEnabled = true
        }
    }
}
