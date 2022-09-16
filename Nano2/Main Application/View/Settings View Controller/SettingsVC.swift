//
//  SettingsVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit
import UserNotifications
import SnapKit

class SettingsVC: UIViewController {

    //MARK: - Properties
    internal lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Settings")
        return label
    }()
    
    internal lazy var integrationTokenTFTitle: RLabel = {
        let label = RLabel(style: .tfTitle, textString: "Integration Token")
        return label
    }()
    
    internal lazy var integrationTokenTF: RTextField = {
        let tf = RTextField(placeholderText: "Integration Token")
        tf.text = UserDefaults.standard.string(forKey: "integrationToken")
        return tf
    }()
    
    internal lazy var databaseIDTFTitle: RLabel = {
        let label = RLabel(style: .tfTitle, textString: "Database ID")
        return label
    }()
    
    internal lazy var databaseIDTF: RTextField = {
        let tf = RTextField(placeholderText: "Database ID")
        tf.text = UserDefaults.standard.string(forKey: "databaseID")
        return tf
    }()
    
    internal lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    internal lazy var enableNotificationsButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Enable notifications", #selector(handleNotificationButtonTapped), self)
        return button
    }()
    
    internal lazy var toSettingsButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Enable in Settings", #selector(handleToSettingsButtonTapped), self)
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
                RNotifications().addNotification()
                
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
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(26)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(151)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        let integrationStack = UIStackView(arrangedSubviews: [integrationTokenTFTitle, integrationTokenTF])
        integrationStack.spacing = 7
        integrationStack.axis = .vertical
        view.addSubview(integrationStack)
        integrationStack.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(view.frame.height / 14.07)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        let databaseStack = UIStackView(arrangedSubviews: [databaseIDTFTitle, databaseIDTF])
        databaseStack.spacing = 5
        databaseStack.axis = .vertical
        view.addSubview(databaseStack)
        databaseStack.snp.makeConstraints { make in
            make.top.equalTo(integrationStack.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        if check == false {
            
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { settings in
                
                if settings.authorizationStatus == .denied {
                    DispatchQueue.main.async {
                        self.view.addSubview(self.toSettingsButton)
                        self.toSettingsButton.snp.makeConstraints { make in
                            make.leading.equalToSuperview().offset(20)
                            make.trailing.equalToSuperview().offset(-20)
                            make.bottom.equalToSuperview().offset(-250)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view.addSubview(self.enableNotificationsButton)
                        self.enableNotificationsButton.snp.makeConstraints { make in
                            make.leading.equalToSuperview().offset(20)
                            make.trailing.equalToSuperview().offset(-20)
                            make.bottom.equalToSuperview().offset(-250)
                        }
                    }
                }
            }
        }
    }
}
