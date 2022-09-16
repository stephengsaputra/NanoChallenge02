//
//  EmojiPickerVC.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 26/07/22.
//

import UIKit
import SnapKit

class EmojiPickerVC: UIViewController {
    
    //MARK: - Properties
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .textColor
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headingLabel: RLabel = {
        let label = RLabel(style: .heading, textString: "Next, share your feelings today")
        return label
    }()
    
    private lazy var subHeadingLabel: RLabel = {
        let label = RLabel(style: .subHeading, textString: "Choose one that suits your mood")
        return label
    }()
    
    private lazy var nextButton: RTButton = {
        let button = RTButton(isEnabled: false, style: .normal, text: "Next", #selector(handleNextButtonTapped), self)
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
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(26)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(151)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        view.addSubview(subHeadingLabel)
        subHeadingLabel.snp.makeConstraints { make in
            make.top.equalTo(headingLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        let views = [excitedEmojiView, happyEmojiView, alrightEmojiView, mehEmojiView, unhappyEmojiView, stressedEmojiView]
        views.forEach {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onViewSelected(_:)))
            $0.addGestureRecognizer(tapGesture)
            
            $0.snp.makeConstraints { make in
                make.height.equalTo(view.frame.width / 3.57)
                make.width.equalTo(view.frame.width / 3.57)
            }
            
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
        stack1.snp.makeConstraints { make in
            make.top.equalTo(subHeadingLabel.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        let stack2 = UIStackView(arrangedSubviews: [mehEmojiView, unhappyEmojiView, stressedEmojiView])
        stack2.axis = .horizontal
        stack2.spacing = 10
        
        view.addSubview(stack2)
        stack2.snp.makeConstraints { make in
            make.top.equalTo(stack1.snp.bottom).offset(10)
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
