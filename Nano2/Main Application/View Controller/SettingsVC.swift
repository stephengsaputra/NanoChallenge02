//
//  SettingsVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit
import UserNotifications

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
    
    private lazy var enableNotificationsButton: AppButton = {
        let button = AppButton(isEnabled: true, style: .normal, text: "Enable notifications", #selector(handleNotificationButtonTapped), self)
        return button
    }()
    
    private lazy var toSettingsButton: AppButton = {
        let button = AppButton(isEnabled: true, style: .normal, text: "Enable in Settings", #selector(handleToSettingsButtonTapped), self)
        return button
    }()
    
    var check = false
    let notification = UNUserNotificationCenter.current()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        checkNotification()
        configureUI()
        configureTextFieldObservers()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    //MARK: - Selectors
    @objc func handleBackButtonTapped() {
        UserDefaults.standard.set(integrationTokenTF.text ?? "", forKey: "integrationToken")
        UserDefaults.standard.set(databaseIDTF.text ?? "", forKey: "databaseID")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNotificationButtonTapped() {
        notification.requestAuthorization(
            options: [.alert, .sound, .badge]) { permissionGranted, error in
                Utilities().addNotification()
                
                // Push new controller after user agrees
                let center = UNUserNotificationCenter.current()
                center.getNotificationSettings { settings in
                    DispatchQueue.main.async {
                        
                        if settings.authorizationStatus == .denied {
                            print("Push notification is denied")
                            self.present(self.doNotAllowAlert(), animated: true)
                        }
                    }
                }
            }
    }
    
    @objc func handleToSettingsButtonTapped() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            
            if UIApplication.shared.canOpenURL(url) {
                
                // If we can open this settings URL, then open it
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
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
        integrationStack.spacing = 7
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
        
        if check == false {
            
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { settings in
                
                if settings.authorizationStatus == .denied {
                    DispatchQueue.main.async {
                        self.view.addSubview(self.toSettingsButton)
                        self.toSettingsButton.anchor(
                            left: self.view.leftAnchor,
                            bottom: self.view.bottomAnchor,
                            right: self.view.rightAnchor,
                            paddingLeft: 20,
                            paddingBottom: 250,
                            paddingRight: 20
                        )
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.addSubview(self.enableNotificationsButton)
                        self.enableNotificationsButton.anchor(
                            left: self.view.leftAnchor,
                            bottom: self.view.bottomAnchor,
                            right: self.view.rightAnchor,
                            paddingLeft: 20,
                            paddingBottom: 250,
                            paddingRight: 20
                        )
                    }
                }
            }
        }
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
    
    func checkNotification() {
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in

            if settings.authorizationStatus == .authorized {
                print("Push notification is enabled")
                self.check = true
            } else if settings.authorizationStatus == .denied {
                print("Push notification is denied")
                self.check = false
            } else {
                print("Push notification is not enabled")
                self.check = false
            }
        }
    }
    
    func doNotAllowAlert() -> UIViewController {
        
        let alert = UIAlertController(
            title: "Reminders Not Allowed!",
            message: "If this is an accident, you can turn on the notifications in Settings.",
            preferredStyle: .alert
        )
        alert.view.tintColor = UIColor.textColor
        
        let action = UIAlertAction(title: "Alrighty!", style: .cancel) { action in
            self.dismiss(animated: true)
            UIView.animate(withDuration: 0.5) {
                self.enableNotificationsButton.alpha = 0
            }
        }
        
        alert.addAction(action)
        
        return alert
    }
}
