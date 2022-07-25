//
//  FinishSetupVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class FinishSetupVC: UIViewController {

    //MARK: - Properties
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Congrats!!")
        return label
    }()
    
    private lazy var illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "finishSetup")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var bodyLabel1: AppLabel = {
        let label = AppLabel(style: .body, textString: "You have successfully unlocked the ultimate Reflections hack!")
        return label
    }()
    
    private lazy var bodyLabel2: UILabel = {
        let label = AppLabel(style: .body, textString: "You can always change those ID’s from the Settings screen")
        return label
    }()
    
    private lazy var startWritingButton: AppButton = {
        let button = AppButton(style: .normal, text: "Start writing!", #selector(handleButtonTapped), self)
        return button
    }()
    
    let notification = UNUserNotificationCenter.current()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        OnboardingManager().setOnboardingSeen()
        navigationController?.pushViewController(TitleInputVC(), animated: true)
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
        
        startWritingButton.alpha = 0
        view.addSubview(startWritingButton)
        startWritingButton.centerX(inView: view)
        startWritingButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 5
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.startWritingButton.alpha = 1
            }
        }
    }
}
