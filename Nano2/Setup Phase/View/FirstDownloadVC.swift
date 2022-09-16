//
//  FirstDownloadVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 22/07/22.
//

import UIKit
import SnapKit

class FirstDownloadVC: UIViewController {
    
    //MARK: - Properties
    private lazy var emojiHi: UILabel = {
        let label = UILabel()
        label.text = "👋🏻"
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()
    
    private lazy var welcomeLabel: RLabel = {
        let label = RLabel(style: .largeTitle, textString: "Welcome!!")
        return label
    }()
    
    private lazy var subHeadingLabel1: RLabel = {
        let label = RLabel(style: .subHeading, textString: "Experience a new way to\nwrite Reflections")
        return label
    }()
    
    private lazy var subHeadingLabel2: UILabel = {
        let label = RLabel(style: .subHeading, textString: "By a Learner, for all Learners")
        return label
    }()
    
    private lazy var nextButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Let's get started!", #selector(handleButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        print("Test")
        navigationController?.pushViewController(FirstSetupVC(), animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(emojiHi)
        emojiHi.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(160)
            make.leading.equalToSuperview().offset(14)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiHi.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
        }
        
        subHeadingLabel1.alpha = 0
        view.addSubview(subHeadingLabel1)
        subHeadingLabel1.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(20)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) {
                self.subHeadingLabel1.alpha = 1
            }
        }
        
        subHeadingLabel2.alpha = 0
        view.addSubview(subHeadingLabel2)
        subHeadingLabel2.snp.makeConstraints { make in
            make.top.equalTo(subHeadingLabel1.snp.bottom).offset(140)
            make.leading.equalToSuperview().offset(20)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.subHeadingLabel2.alpha = 1
            }
        }
        
        nextButton.alpha = 0
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
            UIView.animate(withDuration: 0.5) {
                self.nextButton.alpha = 1
            }
        }
    }
}
