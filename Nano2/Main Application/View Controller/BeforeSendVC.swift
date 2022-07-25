//
//  BeforeSendVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class BeforeSendVC: UIViewController {

    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Before we send, one last check")
        return label
    }()
    
    private lazy var reflectionTitleLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: UserDefaults.standard.string(forKey: "reflectionTitle") ?? "")
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        return label
    }()
    
    private lazy var reflectionEmojiLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Your mood today: 😉")
        label.font = UIFont(name: "Raleway-Bold", size: 16)
        return label
    }()
    
    private lazy var textView: UITextView = {
        let tv = AppTextView(style: .nonEditable ,placeholderText: "Write it down here...")
        tv.text = UserDefaults.standard.string(forKey: "reflectionBody")
        return tv
    }()
    
    private lazy var sendButton: AppButton = {
        let button = AppButton(style: .normal, text: "Send", #selector(handleSendButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    //MARK: - Selectors
    @objc func handleBackButtonTapped() {
        navigationController?.popViewController(animated: true)
        print(UserDefaults.standard.string(forKey: "reflectionBody"))
    }
    
    @objc func handleSendButtonTapped() {
        
        Helper.sendReflection()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        
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
        
        view.addSubview(reflectionTitleLabel)
        reflectionTitleLabel.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 32,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(reflectionEmojiLabel)
        reflectionEmojiLabel.anchor(
            top: reflectionTitleLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 10,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(sendButton)
        sendButton.centerX(inView: view)
        sendButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 5
        )
        
        view.addSubview(textView)
        textView.anchor(
            top: reflectionEmojiLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: sendButton.topAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 20,
            paddingBottom: 20,
            paddingRight: 20
        )
    }
}

extension BeforeSendVC {
    
    func showFailedVC() {
        navigationController?.pushViewController(FailedSubmitVC(), animated: true)
    }
    
    func showSuccessVC() {
        navigationController?.pushViewController(SuccessSubmitVC(), animated: true)
    }
}
