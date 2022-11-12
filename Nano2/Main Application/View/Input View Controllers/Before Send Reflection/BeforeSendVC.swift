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
    }
    
    @objc func handleSendButtonTapped() {
        sendReflection()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        
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
        
        view.addSubview(reflectionTitleLabel)
        reflectionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(reflectionEmojiLabel)
        reflectionEmojiLabel.snp.makeConstraints { make in
            make.top.equalTo(reflectionTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(reflectionEmojiLabel.snp.bottom).offset(16)
            make.bottom.equalTo(sendButton.snp.top).offset(-16)
        }
    }
}
