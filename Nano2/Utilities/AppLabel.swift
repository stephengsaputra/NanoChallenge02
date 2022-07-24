//
//  AppLabel.swift
//  Nano2
//
//  Created by Stephen Giovanni Saputra on 24/07/22.
//

import UIKit

class AppLabel: UILabel {

    enum Style {
        case largeTitle
        case heading
        case subHeading
        case body
    }

    //MARK: - Initializers
    public private(set) var style: Style
    public private(set) var textString: String
    
    init(style: Style, textString: String) {
        
        self.style = style
        self.textString = textString
        
        super.init(frame: .zero)
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func configureLabel() {
        
        configureLabelText()
        configureLabelStyle()
    }
    
    private func configureLabelText() {
        self.text = textString
    }
    
    private func configureLabelStyle() {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = CGFloat(24)
        paragraphStyle.maximumLineHeight = CGFloat(24)
        
        switch style {
        case .largeTitle:
            self.font = UIFont.largeTitle()
            self.text = textString
        case .heading:
            self.font = UIFont.heading()
            self.text = textString
        case .subHeading:
            self.font = UIFont.subHeading()
            
            self.attributedText = NSAttributedString(
                string: textString,
                attributes: [
                    .paragraphStyle: paragraphStyle
                ])
        case .body:
            self.font = UIFont.body()
            
            self.attributedText = NSAttributedString(
                string: textString,
                attributes: [
                    .paragraphStyle: paragraphStyle
                ])
        }
        
        self.textColor = .textColor
        self.numberOfLines = 4
    }
}
