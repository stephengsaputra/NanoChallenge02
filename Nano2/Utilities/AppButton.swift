//
//  ReusableButton.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 23/07/22.
//

import UIKit

class AppButton: UIButton {

    enum Style {
        case normal
        case disabled
        case destructive
    }
    
    //MARK: - Initializers
    public private(set) var style: Style
    public private(set) var text: String
    public private(set) var action: Selector
    public private(set) var target: Any
    
    init(style: Style, text: String, _ action: Selector, _ target: Any) {
        
        self.style = style
        self.text = text
        self.action = action
        self.target = target
        
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func configureButton() {
        
        configureButtonText()
        configureButtonStyle()
        configureButtonTarget()
    }
    
    private func configureButtonStyle() {
        
        switch style {
            case .normal:
                backgroundColor = .textColor
                setTitleColor(.backgroundColor, for: .normal)
            case .disabled:
                backgroundColor = UIColor(named: "disabledButtonBG")
                setTitleColor(UIColor(named: "disabledButtonText"), for: .normal)
                self.alpha = 0.5
                isEnabled = false
            case .destructive:
                backgroundColor = UIColor(named: "customRed")
                setTitleColor(.white, for: .normal)
        }
        
        self.titleLabel?.font = UIFont.buttonText()
        self.setDimensions(height: 50, width: UIScreen.main.bounds.width - 40)
        self.layer.cornerRadius = 12
    }
    
    private func configureButtonText() {
        setTitle(text, for: .normal)
    }
    
    private func configureButtonTarget() {
        addTarget(target, action: action, for: .touchUpInside)
    }
}
