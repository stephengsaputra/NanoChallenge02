//
//  BodyInputVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit
import SnapKit

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
    }
    
    @objc func handleFinishButtonTapped() {
        UserDefaults.standard.set(textView.text ?? "", forKey: "reflectionBody")
        navigationController?.pushViewController(BeforeSendVC(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(26)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(151)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(finishButton)
        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(headingLabel.snp.bottom).offset(16)
            make.bottom.equalTo(finishButton.snp.top).offset(16)
        }
    }
}
