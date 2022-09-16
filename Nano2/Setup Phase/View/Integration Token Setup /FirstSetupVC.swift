//
//  FirstSetupVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 24/07/22.
//

import UIKit
import SnapKit

class FirstSetupVC: UIViewController {

    //MARK: - Properties
    var setupContent: [Setup] = [
        Setup(image: "1-1", step1: "On your Safari or Chrome, login to your ADA Notion account", step2: "Then, open up notion.so/my-integrations and click the “New integration” button"),
        Setup(image: "1-2", step1: "Fill in the Integration Name (anything you want) and choose your Personal Workspace", step2: "When finished, click Submit"),
        Setup(image: "1-3", step1: "Save your unique Integration Token! You will use it on the next screen, so write it where you can easily paste it in\n\n(I prefer Apple's Notes)", step2: "Congratulations! You are halfway there 🙌🏻")
    ]
    
    var contentIsShown: Int = 0
    
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "First Setup")
        return label
    }()
    
    private lazy var subtitleLabel: RLabel = {
        let label = RLabel(style: .subHeading, textString: "I know you can do it 💪🏻")
        return label
    }()
    
    private lazy var illustrationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: setupContent[contentIsShown].image)?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var stepLabel1: RLabel = {
        let label = RLabel(style: .body, textString: setupContent[contentIsShown].step1)
        return label
    }()
    
    private lazy var stepLabel2: UILabel = {
        let label = RLabel(style: .body, textString: setupContent[contentIsShown].step2)
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .textColor
        pageControl.pageIndicatorTintColor = .systemGray6
        pageControl.numberOfPages = setupContent.count
        pageControl.currentPage = contentIsShown
        pageControl.backgroundStyle = .minimal
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private lazy var nextButton: RTButton = {
        let button = RTButton(isEnabled: true, style: .normal, text: "I got it!", #selector(handleButtonTapped), self)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleButtonTapped() {
        
        if contentIsShown < 2 {
            
            contentIsShown += 1
            
            // Hide the assets on screen before showing the new ones
            UIView.animate(withDuration: 0.5) {
                self.illustrationImage.alpha = 0
                self.stepLabel1.alpha = 0
                self.stepLabel2.alpha = 0
            }
            
            // To display the image
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 0.5) {
                    self.illustrationImage.image = UIImage(named: self.setupContent[self.contentIsShown].image)
                    self.illustrationImage.alpha = 1
                }
            }
            
            // To display the steps
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 0.5) {
                    self.stepLabel1.text = self.setupContent[self.contentIsShown].step1
                    self.stepLabel1.alpha = 1
                    self.stepLabel2.text = self.setupContent[self.contentIsShown].step2
                    self.stepLabel2.alpha = 1
                }
            }
            
            pageControl.currentPage = contentIsShown
            
        } else {
            contentIsShown = 0
            navigationController?.pushViewController(IntegrationTokenInputVC(), animated: true)
        }
    }
    
    //MARK: - Helpers
    func configureUI() {
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0 > 20 ? 120 : 80)
            make.leading.equalToSuperview().offset(20)
        }

        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview().offset(20)
        }
        
        illustrationImage.alpha = 0
        view.addSubview(illustrationImage)
        illustrationImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) {
                self.illustrationImage.alpha = 1
            }
        }
        
        stepLabel1.alpha = 0
        view.addSubview(stepLabel1)
        stepLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(illustrationImage.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        stepLabel2.alpha = 0
        view.addSubview(stepLabel2)
        stepLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stepLabel1.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.5) {
                self.stepLabel1.alpha = 1
                self.stepLabel2.alpha = 1
            }
        }
        
        nextButton.alpha = 0
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5) {
                self.nextButton.alpha = 1
            }
        }
        
        pageControl.alpha = 0
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-25)
            make.centerX.equalToSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 0.5) {
                self.pageControl.alpha = 1
            }
        }
    }
}
