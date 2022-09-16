//
//  FinishSetupVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 25/07/22.
//

import UIKit
import SnapKit

class FinishSetupVC: UIViewController {

    //MARK: - Properties
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Congrats!!")
        return label
    }()
    
    private lazy var illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "finishSetup")?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var bodyLabel1: RLabel = {
        let label = RLabel(style: .body, textString: "You have successfully unlocked the ultimate Reflections hack!")
        return label
    }()
    
    private lazy var bodyLabel2: UILabel = {
        let label = RLabel(style: .body, textString: "You can always change those ID’s from the Settings screen")
        return label
    }()
    
    private lazy var startWritingButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "Start writing!", #selector(handleButtonTapped), self)
        return button
    }()
    
    let notification = UNUserNotificationCenter.current()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        OnboardingManager().setOnboardingSeen()
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
        
        illustrationImage.alpha = 0
        view.addSubview(illustrationImage)
        illustrationImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headingLabel.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) {
                self.illustrationImage.alpha = 1
            }
        }
        
        bodyLabel1.alpha = 0
        view.addSubview(bodyLabel1)
        bodyLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(illustrationImage.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        bodyLabel2.alpha = 0
        view.addSubview(bodyLabel2)
        bodyLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bodyLabel1.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.bodyLabel1.alpha = 1
                self.bodyLabel2.alpha = 1
            }
        }
        
        startWritingButton.alpha = 0
        view.addSubview(startWritingButton)
        startWritingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.startWritingButton.alpha = 1
            }
        }
    }
}
