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
    
    /// MARK: - Initializers
    public private(set) var style: Style
    public private(set) var text: String
    
    init(style: Style, text: String) {
        
        self.style = style
        self.text = text
        
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// MARK: - Methods
    private func configureButton() {
        
        configureButtonText()
        configureButtonStyle()
    }
    
    private func configureButtonStyle() {
        
        switch style {
            case .normal:
                backgroundColor = .textColor
                setTitleColor(.backgroundColor, for: .normal)
                self.setupShadow(
                    opacity: 0.4,
                    radius: 25,
                    offset: CGSize(width: 0.0, height: 8),
                    color: .systemGray
                )
            case .disabled:
                backgroundColor = UIColor(named: "disabledButtonBG")
                setTitleColor(UIColor(named: "disabledButtonText"), for: .normal)
            case .destructive:
                backgroundColor = UIColor(named: "customRed")
                setTitleColor(.white, for: .normal)
                self.setupShadow(
                    opacity: 0.4,
                    radius: 25,
                    offset: CGSize(width: 0.0, height: 8),
                    color: .systemGray
                )
        }
        
        self.titleLabel?.font = UIFont.buttonText()
        self.setDimensions(height: 50, width: UIScreen.main.bounds.width - 40)
        self.layer.cornerRadius = 10
    }
    
    private func configureButtonText() {
        setTitle(text, for: .normal)
    }
}
