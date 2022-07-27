//
//  BodyInputVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit

class BodyInputVC: UIViewController {

    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    internal lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Finally, let’s write your Reflection")
        return label
    }()
    
    internal lazy var textView: RTextView = {
        let tv = RTextView(style: .editable,
            placeholderText: "Write it down here...")
        return tv
    }()
    
    internal lazy var finishButton: RTButton = {
        let button = RTButton(isEnabled: false, style: .normal, text: "Finish", #selector(handleFinishButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        configureTextViewObservers()
        
        RKeyboard().slideViewWhenShowKeyboard(self, #selector(keyboardWillShow(notification:)), #selector(keyboardWillHide))
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    //MARK: - Selectors
    @objc func handleBackButtonTapped() {
        navigationController?.popViewController(animated: true)
        print(UserDefaults.standard.string(forKey: "reflectionBody"))
    }
    
    @objc func handleFinishButtonTapped() {
        UserDefaults.standard.set(textView.text ?? "", forKey: "reflectionBody")
        navigationController?.pushViewController(BeforeSendVC(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
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
        
        view.addSubview(finishButton)
        finishButton.centerX(inView: view)
        finishButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 20
        )
        
        view.addSubview(textView)
        textView.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            bottom: finishButton.topAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 20,
            paddingBottom: 16,
            paddingRight: 20
        )
    }
}
