//
//  NotificationSetupVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 24/07/22.
//

import UIKit
import UserNotifications

class NotificationSetupVC: UIViewController {
    
    //MARK: - Properties
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "One more thing...")
        return label
    }()
    
    private lazy var illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notificationSetup")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var bodyLabel1: RLabel = {
        let label = RLabel(style: .body, textString: "As a Learner, I also want to help other ADA Learners (yes, you) to write Reflections everyday")
        return label
    }()
    
    private lazy var bodyLabel2: UILabel = {
        let label = RLabel(style: .body, textString: "This app can remind you everyday through Notification Center so that you remember to reflect your day")
        return label
    }()
    
    private lazy var agreeNotificationButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Enable notifications", #selector(handleAgreeButtonTapped), self)
        return button
    }()
    
    private lazy var declineNoticicationButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .destructive, text: "No thanks, I’m good", #selector(handleDeclineButtonTapped), self)
        return button
    }()
    
    let notification = UNUserNotificationCenter.current()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(UserDefaults.standard.string(forKey: "integrationToken"))
        print(UserDefaults.standard.string(forKey: "databaseID"))
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleAgreeButtonTapped() {
        
        notification.requestAuthorization(options: [.alert, .sound, .badge]) { permissionGranted, error in
            
            RNotifications().addNotification()
            
            // Push new controller after user agrees
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { settings in
                DispatchQueue.main.async {
                    
                    if settings.authorizationStatus == .authorized {
                        print("Push notification is enabled")
                        self.navigationController?.pushViewController(FinishSetupVC(), animated: true)
                    } else if settings.authorizationStatus == .denied {
                        print("Push notification is denied")
                        self.present(self.doNotAllowAlert(), animated: true)
                    } else {
                        print("Push notification is not enabled")
                        self.present(self.noThanksAlert(), animated: true)
                    }
                }
            }
        }
    }
    
    @objc func handleDeclineButtonTapped() {
        self.present(pushAlertTwoAction(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(headingLabel)
        headingLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 120 : 80,
            paddingLeft: 20
        )
        
        illustrationImage.alpha = 0
        view.addSubview(illustrationImage)
        illustrationImage.centerX(inView: view)
        illustrationImage.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingRight: 0
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) {
                self.illustrationImage.alpha = 1
            }
        }
        
        bodyLabel1.alpha = 0
        view.addSubview(bodyLabel1)
        bodyLabel1.centerX(inView: view)
        bodyLabel1.anchor(
            top: illustrationImage.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        bodyLabel2.alpha = 0
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.bodyLabel1.alpha = 1
                self.bodyLabel2.alpha = 1
            }
        }
        
        declineNoticicationButton.alpha = 0
        view.addSubview(declineNoticicationButton)
        declineNoticicationButton.centerX(inView: view)
        declineNoticicationButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 20
        )
        
        agreeNotificationButton.alpha = 0
        view.addSubview(agreeNotificationButton)
        agreeNotificationButton.centerX(inView: view)
        agreeNotificationButton.anchor(
            left: view.leftAnchor,
            bottom: declineNoticicationButton.topAnchor,
            paddingLeft: 20,
            paddingBottom: 7.5
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.agreeNotificationButton.alpha = 1
                self.declineNoticicationButton.alpha = 1
            }
        }
    }
}
