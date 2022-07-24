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
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "One more thing...")
        return label
    }()
    
    private lazy var illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notificationSetup")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var bodyLabel1: AppLabel = {
        let label = AppLabel(style: .body, textString: "As a Learner, I also want to help other ADA Learners (yes, you) to write Reflections everyday")
        return label
    }()
    
    private lazy var bodyLabel2: UILabel = {
        let label = AppLabel(style: .body, textString: "This app can remind you everyday through Notification Center so that you remember to reflect your day")
        return label
    }()
    
    private lazy var agreeNotificationButton: AppButton = {
        let button = AppButton(style: .normal, text: "Enable notifications")
        button.addTarget(self, action: #selector(handleAgreeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var declineNoticicationButton: AppButton = {
        let button = AppButton(style: .destructive, text: "No thanks, I’m good")
        button.addTarget(self, action: #selector(handleDeclineButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let notification = UNUserNotificationCenter.current()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleAgreeButtonTapped() {
        notification.requestAuthorization(
            options: [.alert, .sound, .badge]) { permissionGranted, error in
            Utilities().addNotification()
        }
        
        navigationController?.pushViewController(FinishSetupVC(), animated: true)
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
            paddingBottom: 5
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.agreeNotificationButton.alpha = 1
                self.declineNoticicationButton.alpha = 1
            }
        }
    }
}

extension NotificationSetupVC {
    
    func pushAlertTwoAction() -> UIViewController {
        
        let alert = UIAlertController(
            title: "Are you sure?",
            message: "This application will not be able to remind you to write your Reflections.",
            preferredStyle: .alert
        )
        alert.view.tintColor = UIColor.textColor
        
        let action1 = UIAlertAction(title: "Yes", style: .cancel) { action in
            self.present(self.pushAlertOneAction(), animated: true)
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .default) { action in
            self.dismiss(animated: true)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        return alert
    }
    
    func pushAlertOneAction() -> UIViewController {
        
        let alert = UIAlertController(
            title: "Reminders Disabled?",
            message: "If you do change your mind, you can always enable it in the Settings page.",
            preferredStyle: .alert
        )
        alert.view.tintColor = UIColor.textColor
        
        let action = UIAlertAction(title: "Alrighty!", style: .cancel) { action in
            self.dismiss(animated: true)
            self.navigationController?.pushViewController(FinishSetupVC(), animated: true)
        }
        
        alert.addAction(action)
        
        return alert
    }
}
