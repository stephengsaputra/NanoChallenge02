//
//  SettingsVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class SettingsVC: UIViewController {

    //MARK: - Properties
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Settings")
        return label
    }()
    
    private lazy var integrationTokenTFTitle: AppLabel = {
        let label = AppLabel(style: .tfTitle, textString: "Integration Token")
        return label
    }()
    
    private lazy var integrationTokenTF: AppTextField = {
        let tf = AppTextField(placeholderText: "Integration Token")
        tf.text = UserDefaults.standard.string(forKey: "integrationToken")
        return tf
    }()
    
    private lazy var databaseIDTFTitle: AppLabel = {
        let label = AppLabel(style: .tfTitle, textString: "Database ID")
        return label
    }()
    
    private lazy var databaseIDTF: AppTextField = {
        let tf = AppTextField(placeholderText: "Database ID")
        tf.text = UserDefaults.standard.string(forKey: "databaseID")
        return tf
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
    }
    
    //MARK: - Selectors
    @objc func handleBackButtonTapped() {
        UserDefaults.standard.set(integrationTokenTF.text ?? "", forKey: "integrationToken")
        UserDefaults.standard.set(databaseIDTF.text ?? "", forKey: "databaseID")
        navigationController?.popViewController(animated: true)
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
        
        let integrationStack = UIStackView(arrangedSubviews: [integrationTokenTFTitle, integrationTokenTF])
        integrationStack.spacing = 5
        integrationStack.axis = .vertical
        view.addSubview(integrationStack)
        integrationStack.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: view.frame.height / 14.07,
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
    }
}

extension SettingsVC {
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        integrationTokenTF.resignFirstResponder()
        databaseIDTF.resignFirstResponder()
    }
    
    private func configureTextFieldObservers() {
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
}
