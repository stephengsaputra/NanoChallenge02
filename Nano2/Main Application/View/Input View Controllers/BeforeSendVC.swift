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
    
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Before we send, one last check")
        return label
    }()
    
    private lazy var reflectionTitleLabel: RLabel = {
        let label = RLabel(style: .heading, textString: UserDefaults.standard.string(forKey: "reflectionTitle") ?? "")
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        return label
    }()
    
    private lazy var reflectionEmojiLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Your mood today: \(UserDefaults.standard.string(forKey: "emoji") ?? "")")
        label.font = UIFont(name: "Raleway-Bold", size: 16)
        return label
    }()
    
    private lazy var textView: UITextView = {
        let tv = RTextView(style: .nonEditable ,placeholderText: "Write it down here...")
        tv.text = UserDefaults.standard.string(forKey: "reflectionBody")
        return tv
    }()
    
    internal lazy var sendButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Send", #selector(handleSendButtonTapped), self)
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
        sendReflection()
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
            paddingBottom: 20
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
