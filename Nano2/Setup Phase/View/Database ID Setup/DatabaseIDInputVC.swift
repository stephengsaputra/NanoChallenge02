//
//  DatabaseIDInputVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 24/07/22.
//

import SnapKit
import UIKit

class DatabaseIDInputVC: UIViewController {

    //MARK: - Initializers
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Finally, paste in your Database ID")
        return label
    }()
    
    internal lazy var databaseIDTF: RTextField = {
        let tf = RTextField(placeholderText: "Database ID")
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
        UserDefaults.standard.set(databaseIDTF.text ?? "", forKey: "databaseID")
        navigationController?.pushViewController(NotificationSetupVC(), animated: true)
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
        
        view.addSubview(databaseIDTF)
        databaseIDTF.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(view.frame.height / 3.4)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
