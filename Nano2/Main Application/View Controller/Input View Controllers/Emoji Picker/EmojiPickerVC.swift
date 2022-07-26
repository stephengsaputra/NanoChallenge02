//
//  EmojiPickerVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 26/07/22.
//

import UIKit

class EmojiPickerVC: UIViewController {
    
    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headingLabel: AppLabel = {
        let label = AppLabel(style: .heading, textString: "Next, share your feelings today")
        return label
    }()
    
    private lazy var subHeadingLabel: AppLabel = {
        let label = AppLabel(style: .subHeading, textString: "Choose one that suits your mood")
        return label
    }()
    
    private lazy var nextButton: AppButton = {
        let button = AppButton(isEnabled: false, style: .normal, text: "Next", #selector(handleNextButtonTapped), self)
        return button
    }()
    
    let excitedEmojiView = EmojiContainerView(emoji: "😆", emotion: "Excited")
    let happyEmojiView = EmojiContainerView(emoji: "😁", emotion: "Happy")
    let alrightEmojiView = EmojiContainerView(emoji: "🙂", emotion: "Alright")
    let mehEmojiView = EmojiContainerView(emoji: "😐", emotion: "Meh")
    let unhappyEmojiView = EmojiContainerView(emoji: "🙁", emotion: "Unhappy")
    let stressedEmojiView = EmojiContainerView(emoji: "😫", emotion: "Stressed")
    
    weak var selectedView: EmojiContainerView? { willSet {
        
            UIView.animate(withDuration: 0.5) {
                // set unselected state
                self.selectedView?.backgroundColor = UIColor(named: "emojiContainerBG")
                self.selectedView?.fontColor = .textColor ?? .lightGray
                
                // set new view to selected state
                newValue?.backgroundColor = .textColor
                newValue?.fontColor = .backgroundColor ?? .lightGray
                
                if newValue != nil {
                    self.nextButton.isEnabled = true
                    self.nextButton.setTitleColor(.backgroundColor, for: .normal)
                    self.nextButton.alpha = 1
                }
            }
        }
    }
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNextButtonTapped() {
        UserDefaults.standard.set(selectedView?.emoji ?? "", forKey: "emoji")
        navigationController?.pushViewController(BodyInputVC(), animated: true)
    }
    
    @objc func onViewSelected(_ sender: UITapGestureRecognizer) {
        selectedView = sender.view as? EmojiContainerView
    }

    
    //MARK: - Helpers
    private func configureUI() {
        
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
        
        view.addSubview(subHeadingLabel)
        subHeadingLabel.anchor(
            top: headingLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 5,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        let views = [excitedEmojiView, happyEmojiView, alrightEmojiView, mehEmojiView, unhappyEmojiView, stressedEmojiView]
        views.forEach {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onViewSelected(_:)))
            $0.addGestureRecognizer(tapGesture)
            $0.setDimensions(height: view.frame.width / 3.57, width: view.frame.width / 3.57)
            $0.layer.cornerRadius = 12
            $0.setupShadow(
                opacity: 0.2,
                radius: 20,
                offset: CGSize(width: 0, height: 0),
                color: .lightGray
            )
        }
        
        let stack1 = UIStackView(arrangedSubviews: [excitedEmojiView, happyEmojiView, alrightEmojiView])
        stack1.axis = .horizontal
        stack1.spacing = 10
        
        view.addSubview(stack1)
        stack1.anchor(
            top: subHeadingLabel.bottomAnchor,
            left: view.leftAnchor,
            paddingTop: 36,
            paddingLeft: 20
        )
        
        let stack2 = UIStackView(arrangedSubviews: [mehEmojiView, unhappyEmojiView, stressedEmojiView])
        stack2.axis = .horizontal
        stack2.spacing = 10
        
        view.addSubview(stack2)
        stack2.anchor(
            top: stack1.bottomAnchor,
            left: view.leftAnchor,
            paddingTop: 10,
            paddingLeft: 20
        )
        
        view.addSubview(nextButton)
        nextButton.anchor(
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            paddingLeft: 20,
            paddingBottom: 20
        )
    }
}
