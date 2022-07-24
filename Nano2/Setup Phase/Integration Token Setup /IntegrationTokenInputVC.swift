//
//  IntegrationTokenInputVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 24/07/22.
//

import UIKit

class IntegrationTokenInputVC: UIViewController {

    //MARK: - Initializers
    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Paste in your Integration Token"
        label.textColor = .textColor
        label.font = UIFont.heading()
        label.numberOfLines = 4
        return label
    }()
    
    var bottomLine: CALayer = {
        let line = CALayer()
        line.frame = CGRect(
            x: 0.0,
            y: 20 + 14,
            width: UIScreen.main.bounds.width - 40,
            height: 1.0
        )
        line.backgroundColor = UIColor.textColor?.cgColor
        return line
    }()
    
    private lazy var integrationTokenTF: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Integration Token")
        tf.autocapitalizationType = .none
        tf.keyboardType = .default
        tf.borderStyle = .none
        tf.layer.addSublayer(bottomLine)
        return tf
    }()
    
    private lazy var nextButton: AppButton = {
        let button = AppButton(style: .disabled, text: "Next")
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
//        button.isEnabled = false
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        
        integrationTokenTF.delegate = self
        integrationTokenTF.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        navigationController?.pushViewController(SecondSetupVC(), animated: true)
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
        
        view.addSubview(integrationTokenTF)
        integrationTokenTF.anchor(
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

extension IntegrationTokenInputVC: UITextFieldDelegate {
    
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
