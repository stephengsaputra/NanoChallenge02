//
//  IntegrationTokenInputVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 24/07/22.
//

import UIKit
import SnapKit

class IntegrationTokenInputVC: UIViewController {

    //MARK: - Initializers
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Paste in your Integration Token")
        return label
    }()
    
    internal lazy var integrationTokenTF: RTextField = {
        let tf = RTextField(placeholderText: "Integration Token")
        tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return tf
    }()
    
    internal lazy var nextButton: RTButton = {
        let button = RTButton(isEnabled: false, style: .normal, text: "Next", #selector(handleButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureTextFieldObservers()
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        UserDefaults.standard.set(integrationTokenTF.text ?? "", forKey: "integrationToken")
        navigationController?.pushViewController(SecondSetupVC(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset( UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 120 : 80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(integrationTokenTF)
        integrationTokenTF.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(view.frame.height / 3.4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
