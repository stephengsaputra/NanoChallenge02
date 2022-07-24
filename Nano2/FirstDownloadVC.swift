//
//  FirstDownloadVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 22/07/22.
//

import UIKit

class FirstDownloadVC: UIViewController {
    
    //MARK: - Properties
    private lazy var emojiHi: UILabel = {
        let label = UILabel()
        label.text = "👋🏻"
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!!"
        label.font = UIFont.largeTitle()
        label.textColor = UIColor.textColor
        return label
    }()
    
    private lazy var subHeadingLabel1: UILabel = {
        let label = UILabel()
        label.text = "Experience a new way to\nwrite Reflections"
        label.font = UIFont.subHeading()
        label.textColor = UIColor.textColor
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var subHeadingLabel2: UILabel = {
        let label = UILabel()
        label.text = "By a Learner, for all Learners"
        label.font = UIFont.subHeading()
        label.textColor = UIColor.textColor
        return label
    }()
    
    private lazy var nextButton: AppButton = {
        let button = AppButton(style: .normal, text: "Let's get started!")
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
        navigationController?.pushViewController(FirstSetupVC(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(emojiHi)
        emojiHi.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            paddingTop: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 160 : 100,
            paddingLeft: 14
        )
        
        view.addSubview(welcomeLabel)
        welcomeLabel.anchor(
            top: emojiHi.bottomAnchor,
            left: view.leftAnchor,
            paddingTop: 5,
            paddingLeft: 20
        )
        
        subHeadingLabel1.alpha = 0
        view.addSubview(subHeadingLabel1)
        subHeadingLabel1.anchor(
            top: welcomeLabel.bottomAnchor,
            left: view.leftAnchor,
            paddingTop: 35,
            paddingLeft: 20
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) {
                self.subHeadingLabel1.alpha = 1
            }
        }
        
        subHeadingLabel2.alpha = 0
        view.addSubview(subHeadingLabel2)
        subHeadingLabel2.anchor(
            top: subHeadingLabel1.bottomAnchor,
            left: view.leftAnchor,
            paddingTop: 140,
            paddingLeft: 20
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.subHeadingLabel2.alpha = 1
            }
        }
        
        nextButton.alpha = 0
        view.addSubview(nextButton)
        nextButton.centerX(inView: view)
        nextButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 0 : 20
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
            UIView.animate(withDuration: 0.5) {
                self.nextButton.alpha = 1
            }
        }
    }
}

