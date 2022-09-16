//
//  FailedSubmitVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit
import SnapKit

class FailedSubmitVC: UIViewController {
    
    //MARK: - Properties
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Uh-oh!!")
        return label
    }()
    
    private lazy var bodyLabel1: RLabel = {
        let label = RLabel(style: .body, textString: "It seems that there has been an error!")
        return label
    }()
    
    internal lazy var bodyLabel2: UILabel = {
        let label = RLabel(style: .body, textString: "To make sure, please recheck your Integration Token and database ID below. You can edit it right here:")
        return label
    }()
    
    internal lazy var integrationTokenTFTitle: RLabel = {
        let label = RLabel(style: .tfTitle, textString: "Integration Token")
        return label
    }()
    
    internal lazy var integrationTokenTF: RTextField = {
        let tf = RTextField(placeholderText: "Integration Token")
        tf.text = UserDefaults.standard.string(forKey: "integrationToken")
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    internal lazy var databaseIDTFTitle: RLabel = {
        let label = RLabel(style: .tfTitle, textString: "Database ID")
        return label
    }()
    
    internal lazy var databaseIDTF: RTextField = {
        let tf = RTextField(placeholderText: "Database ID")
        tf.text = UserDefaults.standard.string(forKey: "databaseID")
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    internal lazy var backToSummaryButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Back to summary", #selector(handleButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
        
        RKeyboard().slideViewWhenShowKeyboard(self, #selector(self.keyboardWillShow(notification:)), #selector(self.keyboardWillHide))
        
        RVibration().vibrate(for: .error)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        UserDefaults.standard.set(integrationTokenTF.text ?? "", forKey: "integrationToken")
        UserDefaults.standard.set(databaseIDTF.text ?? "", forKey: "databaseID")
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 120 : 80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(bodyLabel1)
        bodyLabel1.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(headingLabel.snp.top).offset(32)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(bodyLabel2)
        bodyLabel2.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(bodyLabel1.snp.top).offset(25)
            make.centerX.equalToSuperview()
        }
        
        let integrationStack = UIStackView(arrangedSubviews: [integrationTokenTFTitle, integrationTokenTF])
        integrationStack.spacing = 7
        integrationStack.axis = .vertical
        view.addSubview(integrationStack)
        integrationStack.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(bodyLabel2.snp.bottom).offset(view.frame.height / 7.15)
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
        
        view.addSubview(backToSummaryButton)
        backToSummaryButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }
}
