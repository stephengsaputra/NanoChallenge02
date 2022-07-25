//
//  FailedSubmitVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class FailedSubmitVC: UIViewController {
    
    //MARK: - Properties
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Uh-oh!!")
        return label
    }()
    
    private lazy var bodyLabel1: AppLabel = {
        let label = AppLabel(style: .body, textString: "It seems that there has been an error!")
        return label
    }()
    
    private lazy var bodyLabel2: UILabel = {
        let label = AppLabel(style: .body, textString: "To make sure, please recheck your Integration Token and database ID below. You can edit it right here:")
        return label
    }()
    
    private lazy var integrationTokenTFTitle: AppLabel = {
        let label = AppLabel(style: .tfTitle, textString: "Integration Token")
        return label
    }()
    
    private lazy var integrationTokenTF: AppTextField = {
        let tf = AppTextField(placeholderText: "Integration Token")
        tf.text = UserDefaults.standard.string(forKey: "integrationToken")
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var databaseIDTFTitle: AppLabel = {
        let label = AppLabel(style: .tfTitle, textString: "Database ID")
        return label
    }()
    
    private lazy var databaseIDTF: AppTextField = {
        let tf = AppTextField(placeholderText: "Database ID")
        tf.text = UserDefaults.standard.string(forKey: "databaseID")
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    private lazy var backToSummaryButton: AppButton = {
        let button = AppButton(style: .normal, text: "Back to summary", #selector(handleButtonTapped), self)
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
        UserDefaults.standard.set(integrationTokenTF.text ?? "", forKey: "integrationToken")
        UserDefaults.standard.set(databaseIDTF.text ?? "", forKey: "databaseID")
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        Utilities().vibrate(for: .error)
        view.backgroundColor = .backgroundColor
        
        view.addSubview(headingLabel)
        headingLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 120 : 80,
            paddingLeft: 20
        )
        
        view.addSubview(bodyLabel1)
        bodyLabel1.centerX(inView: view)
        bodyLabel1.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 32,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(bodyLabel2)
        bodyLabel2.centerX(inView: view)
        bodyLabel2.anchor(
            top: bodyLabel1.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 25,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        let integrationStack = UIStackView(arrangedSubviews: [integrationTokenTFTitle, integrationTokenTF])
        integrationStack.spacing = 7
        integrationStack.axis = .vertical
        view.addSubview(integrationStack)
        integrationStack.anchor(
            top: bodyLabel2.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: view.frame.height / 7.15,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        let databaseStack = UIStackView(arrangedSubviews: [databaseIDTFTitle, databaseIDTF])
        databaseStack.spacing = 5
        databaseStack.axis = .vertical
        view.addSubview(databaseStack)
        databaseStack.anchor(
            top: integrationStack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 45,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(backToSummaryButton)
        backToSummaryButton.centerX(inView: view)
        backToSummaryButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 20
        )
    }
}

extension FailedSubmitVC {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpacing = self.view.frame.height - (bodyLabel2.frame.origin.y + bodyLabel2.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpacing + 400
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
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
    
    private func configureTextFieldObservers() {
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
}
