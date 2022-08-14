//
//  RTButton.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 23/07/22.
//

import UIKit

class RTButton: UIButton {

    enum Style {
        case normal
        case destructive
        
        var foregroundColor: UIColor? { get {
            return self == .normal ? .backgroundColor : .white
        }}
        
        var backgroundColor: UIColor? { get {
            return self == .normal ? .textColor : UIColor(named: "customRed")
        }}
        
        var disabledForegroundColor: UIColor? { get {
            return UIColor(named: "disabledButtonText")
        }}
        
        var disabledBackgroundColor: UIColor? { get {
            UIColor(named: "disabledButtonBG")
        }}
    }
    
    override var isEnabled: Bool { didSet {
        super.isEnabled = isEnabled
        // set styling
        backgroundColor = isEnabled ? style.backgroundColor : style.disabledBackgroundColor
        setTitleColor(isEnabled ? style.foregroundColor : style.disabledForegroundColor, for: .normal)
        self.alpha = isEnabled ? 1.0 : 0.5
    }}
    
    //MARK: - Initializers
    public private(set) var style: Style
    public private(set) var text: String
    public private(set) var action: Selector
    public private(set) var target: Any
    
    init(isEnabled: Bool, style: Style, text: String, _ action: Selector, _ target: Any) {
        
        self.style = style
        self.text = text
        self.action = action
        self.target = target
        
        super.init(frame: .zero)
        
        self.isEnabled = isEnabled
        
        // in order to invoke didSet
        ({ self.isEnabled = self.isEnabled })()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.allowUserInteraction, .curveEaseIn]) {
                self.transform = .init(scaleX: 0.975, y: 0.975)
            }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesEnded(touches, with: event)
        
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.allowUserInteraction, .curveEaseOut]) {
                self.transform = .identity
            }
    }
}
