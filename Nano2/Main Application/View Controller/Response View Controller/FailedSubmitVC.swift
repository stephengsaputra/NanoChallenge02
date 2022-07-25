//
//  FailedSubmitVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class FailedSubmitVC: UIViewController {
    
    //MARK: - Properties
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Uh-oh!!")
        return label
    }()
    
    private lazy var bodyLabel1: AppLabel = {
        let label = AppLabel(style: .body, textString: "It seems that there has been an error!")
        return label
    }()
    
    private lazy var bodyLabel2: UILabel = {
        let label = AppLabel(style: .body, textString: "To make sure, please recheck your Integration Token and database ID below. You can edit it right here:")
        return label
    }()
    
    private lazy var integrationTokenTFTitle: AppLabel = {
        let label = AppLabel(style: .tfTitle, textString: "Integration Token")
        return label
    }()
    
    private lazy var integrationTokenTF: AppTextField = {
        let tf = AppTextField(placeholderText: "Integration Token")
        tf.text = UserDefaults.standard.string(forKey: "integrationToken")
        return tf
    }()
    
    private lazy var databaseIDTFTitle: AppLabel = {
        let label = AppLabel(style: .tfTitle, textString: "Database ID")
        return label
    }()
    
    private lazy var databaseIDTF: AppTextField = {
        let tf = AppTextField(placeholderText: "Database ID")
        tf.text = UserDefaults.standard.string(forKey: "databaseID")
        return tf
    }()
    
    private lazy var startWritingButton: AppButton = {
        let button = AppButton(style: .normal, text: "Back to summary", #selector(handleButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
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
        headingLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            paddingTop: UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 120 : 80,
            paddingLeft: 20
        )
        
        view.addSubview(bodyLabel1)
        bodyLabel1.centerX(inView: view)
        bodyLabel1.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 32,
            paddingLeft: 20,
            paddingRight: 20
        )
        
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
        
        let integrationStack = UIStackView(arrangedSubviews: [integrationTokenTFTitle, integrationTokenTF])
        integrationStack.spacing = 7
        integrationStack.axis = .vertical
        view.addSubview(integrationStack)
        integrationStack.anchor(
            top: bodyLabel2.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: view.frame.height / 7.15,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        let databaseStack = UIStackView(arrangedSubviews: [databaseIDTFTitle, databaseIDTF])
        databaseStack.spacing = 5
        databaseStack.axis = .vertical
        view.addSubview(databaseStack)
        databaseStack.anchor(
            top: integrationStack.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 45,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        view.addSubview(startWritingButton)
        startWritingButton.centerX(inView: view)
        startWritingButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 5
        )
    }
}
