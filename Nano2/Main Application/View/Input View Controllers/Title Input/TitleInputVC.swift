//
//  TitleInputVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit
import SnapKit

class TitleInputVC: UIViewController {

    //MARK: - Properties
    private lazy var largeTitleLabel: RLabel = {
        let label = RLabel(style: .largeTitle, textString: "Let’s write your Reflections")
        return label
    }()
    
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "First, let’s write\ndown a Title")
        return label
    }()
    
    private lazy var bodyLabel: RLabel = {
        let label = RLabel(style: .body, textString: "It could be anything you want 😚")
        return label
    }()
    
    internal lazy var reflectionsTitleTF: RTextField = {
        let tf = RTextField(placeholderText: "Reflections Title")
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    internal lazy var nextButton: RTButton = {
        let button = RTButton(isEnabled: false, style: .normal, text: "Next", #selector(handleNextButtonTapped), self)
        return button
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settingsIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleSettingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        RKeyboard().slideViewWhenShowKeyboard(self, #selector(self.keyboardWillShow(notification:)), #selector(self.keyboardWillHide))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Selectors
    @objc func handleNextButtonTapped() {
        UserDefaults.standard.set(reflectionsTitleTF.text ?? "", forKey: "reflectionTitle")
        navigationController?.pushViewController(EmojiPickerVC(), animated: true)
    }
    
    @objc func handleSettingsButtonTapped() {
        navigationController?.pushViewController(SettingsVC(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(settingsButton)
        settingsButton.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height / 19.2)
            make.width.equalTo(view.frame.width / 8.53)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(26)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        view.addSubview(largeTitleLabel)
        largeTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 140 : 100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.top.equalTo(largeTitleLabel.snp.bottom).offset(view.frame.height / 10.68)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(reflectionsTitleTF)
        reflectionsTitleTF.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
