//
//  SuccessSubmitVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit
import SnapKit

class SuccessSubmitVC: UIViewController {

    //MARK: - Properties
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Success!!")
        return label
    }()
    
    private lazy var illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "successSend")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var bodyLabel1: RLabel = {
        let label = RLabel(style: .body, textString: "Your Reflection has been successfully uploaded to your Notion database!")
        return label
    }()
    
    private lazy var bodyLabel2: UILabel = {
        let label = RLabel(style: .body, textString: "Remember to keep writing your Reflections everyday consistently 🔥")
        return label
    }()
    
    private lazy var backToMainButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Back to main", #selector(handleButtonTapped), self)
        return button
    }()
    
    let sceneDelegate = UIApplication.shared.connectedScenes.first
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        RVibration().vibrate(for: .success)
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        
        UserDefaults.standard.set("", forKey: "reflectionTitle")
        UserDefaults.standard.set("", forKey: "emoji")
        UserDefaults.standard.set("", forKey: "reflectionBody")
        
        navigationController?.pushViewController(TitleInputVC(), animated: true)
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
        
        view.addSubview(illustrationImage)
        illustrationImage.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.top).offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(bodyLabel1)
        bodyLabel1.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(illustrationImage.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(bodyLabel2)
        bodyLabel2.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(bodyLabel1.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(backToMainButton)
        backToMainButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
