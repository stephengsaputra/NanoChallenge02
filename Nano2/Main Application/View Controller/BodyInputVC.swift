//
//  BodyInputVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class BodyInputVC: UIViewController {

    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Finally, let’s write your Reflection")
        return label
    }()
    
    private lazy var textView: AppTextView = {
        let tv = AppTextView(style: .editable,
            placeholderText: "Write it down here...")
        return tv
    }()
    
    private lazy var finishButton: AppButton = {
        let button = AppButton(style: .disabled, text: "Finish", #selector(handleFinishButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureTextViewObservers()
        
        Utilities().slideViewWhenShowKeyboard(self, #selector(keyboardWillShow(notification:)), #selector(keyboardWillHide))
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    //MARK: - Selectors
    @objc func handleBackButtonTapped() {
        UserDefaults.standard.set(textView.text ?? "", forKey: "reflectionBody")
        navigationController?.popViewController(animated: true)
        print(UserDefaults.standard.string(forKey: "reflectionBody"))
    }
    
    @objc func handleFinishButtonTapped() {
        UserDefaults.standard.set(textView.text ?? "", forKey: "reflectionBody")
        navigationController?.pushViewController(BeforeSendVC(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(backButton)
        backButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            paddingTop: 26,
            paddingLeft: 20
        )
        
        view.addSubview(headingLabel)
        headingLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 151,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(finishButton)
        finishButton.centerX(inView: view)
        finishButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 20
        )
        
        view.addSubview(textView)
        textView.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: finishButton.topAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 20,
            paddingBottom: 16,
            paddingRight: 20
        )
    }
}

extension BodyInputVC {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let bottomSpacing = self.view.frame.height - (finishButton.frame.origin.y + finishButton.frame.height)
            self.view.frame.origin.y -= keyboardHeight - bottomSpacing + 50
        }
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textView.resignFirstResponder()
        
        if textView.text != nil && textView.text!.isEmpty {
            finishButton.isEnabled = false
        } else {
            finishButton.isEnabled = true
        }
    }
    
    private func configureTextViewObservers() {
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    
}
