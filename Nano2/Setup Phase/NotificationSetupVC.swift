//
//  NotificationSetupVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 24/07/22.
//

import UIKit

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
    
    private lazy var stepLabel1: AppLabel = {
        let label = AppLabel(style: .body, textString: "As a Learner, I also want to help other ADA Learners (yes, you) to write Reflections everyday")
        return label
    }()
    
    private lazy var stepLabel2: UILabel = {
        let label = AppLabel(style: .body, textString: "This app can remind you everyday through Notification Center so that you remember to reflect your day")
        return label
    }()
    
    private lazy var nextButton: AppButton = {
        let button = AppButton(style: .normal, text: "Enable notifications")
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var declineButton: AppButton = {
        let button = AppButton(style: .destructive, text: "No thanks, I’m good")
        button.addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        print("Test")
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
        
        stepLabel1.alpha = 0
        view.addSubview(stepLabel1)
        stepLabel1.centerX(inView: view)
        stepLabel1.anchor(
            top: illustrationImage.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        stepLabel2.alpha = 0
        view.addSubview(stepLabel2)
        stepLabel2.centerX(inView: view)
        stepLabel2.anchor(
            top: stepLabel1.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 25,
            paddingLeft: 20,
            paddingRight: 20
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.stepLabel1.alpha = 1
                self.stepLabel2.alpha = 1
            }
        }
        
        declineButton.alpha = 0
        view.addSubview(declineButton)
        declineButton.centerX(inView: view)
        declineButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 20
        )
        
        nextButton.alpha = 0
        view.addSubview(nextButton)
        nextButton.centerX(inView: view)
        nextButton.anchor(
            left: view.leftAnchor,
            bottom: declineButton.topAnchor,
            paddingLeft: 20,
            paddingBottom: 5
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.nextButton.alpha = 1
                self.declineButton.alpha = 1
            }
        }
    }
}
