//
//  EmojiContainerView.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 26/07/22.
//

import UIKit

class EmojiContainerView: UIView {
    
    // MARK: - Properties
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()
    
    private lazy var emotionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Raleway-Bold", size: 16)
        label.textColor = .textColor
        return label
    }()
    
    var fontColor: UIColor = .textColor ?? .lightGray {
        didSet {
            emotionLabel.textColor = fontColor
        }
    }
    
    var emoji: String = "" {
        didSet {
            emojiLabel.text = emoji
        }
    }
    
    var emotion: String = "" {
        didSet {
            emotionLabel.text = emotion
        }
    }
    
    //MARK: - Lifecycle
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        commonInit()
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    init(emoji: String, emotion: String) {
        
        self.emoji = emoji
        self.emotion = emotion
        
        super.init(frame: .zero)
        commonInit()
    }
    
    override func awakeFromNib() {
        setupEmojiContainer()
    }
    
    private func commonInit() {
        
        backgroundColor = UIColor(named: "emojiContainerBG")
        
        let stack = UIStackView(arrangedSubviews: [emojiLabel, emotionLabel])
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .center
        
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
        
        setupEmojiContainer()
    }
    
    //MARK: - Helpers
    func setupEmojiContainer() {
        
        emojiLabel.text = emoji
        emotionLabel.text = emotion
    }
}
